<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Traits\RestfulTrait;
use App\Models\Workshop;
use Exception;
use Illuminate\Support\Facades\Hash;

class WorkshopController extends Controller
{
    use RestfulTrait;

    public function register(Request $request)
    {
        $validated = $this->validate($request, [
            'name' => 'required',
            'email' => 'required|email|unique:wf_workshops,email',
            'phone_number' => 'required|unique:wf_workshops,phone_number',
            'password' => 'required|min:6|confirmed',
        ]);

        $validated['password'] = Hash::make($validated['password']);

        // store user information
        try {

            $workshop = Workshop::create($validated);

        } catch (Exception $e) {

            return $this->errorResponse($e->getMessage());

        }

        $message = 'Registration successful';
        return $this->successResponse($message, $workshop);
    }

    public function login(Request $request)
    {
        $this->validate($request, [
            'email' => 'required|email',
            'password' => 'required|min:6'
        ]);

        $email = $request->input('email');
        $password = $request->input('password');

        $workshop = Workshop::where('email', $email)->first();
        if (!$workshop) {
            return $this->errorResponse('Login failed', 401);
        }

        $isValidPassword = Hash::check($password, $workshop->password);
        if (!$isValidPassword) {
            return $this->errorResponse('Login failed', 401);
        }

        $generateToken = bin2hex(random_bytes(40));
        $workshop->update([
            'token' => $generateToken
        ]);

        $message = 'Login successful';
        return $this->successResponse($message, $workshop);
    }

    //
    public function update(Request $request)
    {
        echo 'a';exit;
    }
}