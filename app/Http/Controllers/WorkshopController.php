<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Traits\RestfulTrait;
use App\Models\Workshop;
use Exception;
use Illuminate\Database\Eloquent\ModelNotFoundException;
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
        if (!$workshop = Workshop::create($validated))
            return $this->errorResponse("Error trying to create an account. Please try again.", 400);

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
    public function get($shop = null)
    {
        try {
            
            if ($shop)
                $shops = Workshop::findOrFail($shop);
            else
                $shops = Workshop::all();

        } catch (ModelNotFoundException $e) {

            return $this->errorResponse("Error trying to get workshops data. Please try again.", 400);

        }

        $message = isset($shops) ? 'Workshops data found' : 'No data found';
        return $this->successResponse($message, $shops);
    }

    public function update(Request $request)
    {
        $workshopId = $request->route('shop');
        $extended_validate = [];

        if ($request->input('password')) {
            $extended_validate = [
                'password' => 'required|min:6|confirmed',
            ];
        }
    
        $validated = $this->validate($request, [
            'name' => 'required',
            'email' => 'required|email|unique:wf_workshops,email,'.$workshopId,
            'phone_number' => 'required|unique:wf_workshops,phone_number,'.$workshopId,
            'address' => 'required',
            'city' => 'required',
            'city_district' => 'required',
            'neighbourhood' => 'required',
            'suburb' => 'required',
            'postcode' => 'required',
            'latitude' => 'required',
            'longitude' => 'required',
            'opening_hours' => 'required',
            'gmaps' => 'nullable',
        ] + $extended_validate);

        if ($request->input('password')) {
            $validated['password'] = Hash::make($validated['password']);
        }

        try {
            $workshop = Workshop::findOrFail($workshopId);
            $workshop->update($validated);
        } catch (ModelNotFoundException $e) {
            return $this->errorResponse("Error trying to update profile, please try again.", 400);
        }

        $message = 'Profile updated';
        return $this->successResponse($message, $workshop);
    }
}