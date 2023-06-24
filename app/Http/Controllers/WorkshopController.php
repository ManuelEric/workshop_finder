<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Traits\RestfulTrait;
use App\Models\Booking;
use App\Models\User;
use App\Models\Vehicle;
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

        $workshop['services'] = [];

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

        $workshop = Workshop::with(['services', 'orders', 'orders.user'])->where('email', $email)->first();
        
        foreach ($workshop->orders as $key => $value) {
            $vehicleId = $value->vehicle_id;
            $vehicle = Vehicle::find($vehicleId);

            $workshop->orders[$key]['user']['vehicles'] = [$vehicle]; 
        }

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
            
            if ($shop) {

                $shops = Workshop::with(['services', 'orders'])->findOrFail($shop);
                $new_shops = $shops;

                foreach ($new_shops->orders as $key => $value) {

                    $userId = $value->user_id;
                    $user = User::find($userId);
                    $value['user'] = $user;
                    $vehicleId = $value->vehicle_id;
                    $vehicle = Vehicle::find($vehicleId);

                    $value['user']['vehicles'] = [$vehicle]; 
                }

            } else {

                $shops = Workshop::with(['services', 'orders'])->get();
                $shops = $shops->map(function ($object) {
                    
                    $workshop = [
                        'id' => $object->id,
                        'name' => $object->name,
                        'email' => $object->email,
                        'phone_number' => $object->phone_number,
                        'address' => $object->address,
                        "city" => $object->city,
                        "city_district" => $object->city_district,
                        "neighbourhood" => $object->neighbourhood,
                        "suburb" => $object->suburb,
                        "postcode" => $object->postcode,
                        "latitude" => $object->latitude,
                        "longitude" => $object->longitude,
                        "opening_hours" => $object->opening_hours,
                        "thumbnail" => $object->thumbnail,
                        "webiste" => $object->webiste,
                        "gmaps" => $object->gmaps,
                        "token" => $object->token,
                        "created_at" => $object->created_at,
                        "updated_at" => $object->updated_at,
                    ];

                    $workshop['services'] = $object->services;
                    $workshop['orders'] = $object->orders;
                    
                    foreach ($object->orders as $key => $value) {
                        $userId = $value->user_id;
                        $user = User::find($userId);

                        $vehicleId = $value->vehicle_id;
                        $vehicle = Vehicle::find($vehicleId);

                        $workshop['orders'][$key]['user'] = $user;
                        $workshop['orders'][$key]['user']['vehicles'] = $vehicle;
                        
                    }

                    return $workshop;
                });
                
            }

            return $shops;

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

    public function confirmPayment(Request $request)
    {
        $token = $request->header('token');
        $workshopId = Workshop::where('token', $token)->firstOrFail()->id;

        $bookingCode = $request->booking;
        $booking = Booking::where('booking_code', $bookingCode)->where('workshop_id', $workshopId)->where('status', 1)->firstOrFail();

        $booking->status = 2;
        $booking->save();

        $booking['user']['vehicles'] = [$booking->vehicles];
        unset($booking['vehicles']);

        $message = 'Payment confirmed';
        return $this->successResponse($message, $booking);
        
    }

    public function logout(Request $request)
    {
        $token = $request->header('token');
        $workshop = Workshop::where('token', $token)->firstOrFail();

        $workshop->token = null;
        $workshop->save();

        $message = 'Successfully logged out';
        return $this->successResponse($message, []);
    }
}