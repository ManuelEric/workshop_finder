<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\User;
use Exception;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public function get($user = null)
    {
        if ($user)
            $users = User::find($user);
        else
            $users = User::all();
        
        return response()->json($users->count() > 0 ? $users : 'no data found');

    }

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

            return response()->json([
                'error' => $e->getMessage(),
            ]);

        }

        return response()->json($user);
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
            return response()->json(['message' => 'Login failed'], 401);
        }

        $isValidPassword = Hash::check($password, $user->password);
        if (!$isValidPassword) {
            return response()->json(['message' => 'Login failed'], 401);
        }

        $generateToken = bin2hex(random_bytes(40));
        $user->update([
            'token' => $generateToken
        ]);

        return response()->json($user);
    }
}