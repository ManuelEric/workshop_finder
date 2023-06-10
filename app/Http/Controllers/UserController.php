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
}