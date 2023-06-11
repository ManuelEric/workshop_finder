<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Traits\RestfulTrait;
use App\Models\User;
use Exception;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    use RestfulTrait;

    // auth
    public function register(Request $request)
    {
        $validated = $this->validate($request, [
            'full_name' => 'required',
            'email' => 'required|email|unique:wf_users,email',
            'phone_number' => 'required|unique:wf_users,phone_number',
            'password' => 'required|min:6|confirmed',
        ]);

        $validated['password'] = Hash::make($validated['password']);

        // store user information
        try {

            $user = User::create($validated);

        } catch (Exception $e) {

            return $this->errorResponse($e->getMessage());

        }

        $message = 'Registration successful';
        return $this->successResponse($message, $user);
    }

    public function login(Request $request)
    {
        $this->validate($request, [
            'email' => 'required|email',
            'password' => 'required|min:6'
        ]);

        $email = $request->input('email');
        $password = $request->input('password');

        $user = User::where('email', $email)->first();
        if (!$user) {
            return $this->errorResponse('Login failed', 401);
        }

        $isValidPassword = Hash::check($password, $user->password);
        if (!$isValidPassword) {
            return $this->errorResponse('Login failed', 401);
        }

        $generateToken = bin2hex(random_bytes(40));
        $user->update([
            'token' => $generateToken
        ]);

        $message = 'Login successful';
        return $this->successResponse($message, $user);
    }

    // user
    
    public function get($user = null)
    {
        try {
            
            if ($user)
                $users = User::find($user);
            else
                $users = User::all();

        } catch (Exception $e) {

            return $this->errorResponse($e->getMessage());

        }

        $message = isset($users) ? 'User data found' : 'No data found';
        return $this->successResponse($message, $users);
    }

    public function update(Request $request)
    {
        $userId = $request->route('user');
        $extended_validate = [];

        if ($request->input('password')) {
            $extended_validate = [
                'password' => 'required|min:6|confirmed',
            ];
        }

        $validated = $this->validate($request, [
            'full_name' => 'required',
            'email' => 'required|email|unique:wf_users,email,'.$userId,
            'phone_number' => 'required|unique:wf_users,phone_number,'.$userId,
        ] + $extended_validate);

        if ($request->input('password')) {
            $validated['password'] = Hash::make($validated['password']);
        }

        try {
            $user = User::find($userId);
            $user->update($validated);
        } catch (Exception $e) {
            return $this->errorResponse($e->getMessage());
        }

        $message = 'Profile updated';
        return $this->successResponse($message, $user);
    }
}