<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Traits\RestfulTrait;
use App\Models\User;
use App\Models\Workshop;
use Exception;
use Illuminate\Database\Eloquent\ModelNotFoundException;
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

        $user = User::with('vehicles')->where('email', $email)->first();
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
                $users = User::with('vehicles')->find($user);
            else
                $users = User::with('vehicles')->get();

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

    public function getCurrentLocation($latitude, $longitude)
    {
        $endpoint = "https://nominatim.openstreetmap.org/reverse?lat=".$latitude."&lon=".$longitude."&format=json";
        $client = new \GuzzleHttp\Client();

        $response = $client->request('GET', $endpoint);
        $content = $response->getBody();

        return json_decode($content, true);
    }

    public function find(Request $request)
    {
        $latitude = $request->lat ?? "-6.223677865370818";
        $longitude = $request->lon ?? "106.84620569829171";


        $service_type = $request->service_type ?? null;
        $workshop_name = $request->workshop_name ?? null;

        $response = $this->getCurrentLocation($latitude, $longitude);

        $currentLocation = [
            'lat' => $response['lat'],
            'lon' => $response['lon'],
            'neighbourhood' => $response['address']['neighbourhood'] ?? null,
            'suburb' => $response['address']['suburb'] ?? null,
            'city_district' => $response['address']['city_district'] ?? null,
            'city' => $response['address']['city'],
            'postcode' => $response['address']['postcode'],
        ];

        try {
            $workshops = Workshop::withAndWhereHas('services', function ($subQuery) use ($service_type) {
                        $subQuery->when($service_type !== null, function ($subQuery_2) use ($service_type) {
                            $subQuery_2->where('service_type', 'like', '%'.$service_type.'%');
                        });
                    })->
                    when($workshop_name !== null, function ($subQuery) use ($workshop_name) {
                        $subQuery->where('name', 'like', '%'.$workshop_name.'%');
                    })->
                    where('city_district', 'like', '%'.$currentLocation['city_district'].'%')->
                    where('neighbourhood', 'like', '%'.$currentLocation['neighbourhood'].'%')->
                    get();

        } catch (\Illuminate\Database\QueryException $e) {
            return $this->errorResponse("Error trying to get workshops nearby, please try again.", 400);
        } catch (ModelNotFoundException $e) {
            return $this->errorResponse("Error trying to get workshops nearby, please try again.", 400);
        }

        if ($workshops->count() == 0) {
            $message = "We cannot found any workshops nearby.";
            return $this->successResponse($message, []);
        }

        $message = "There are workshops nearby can be found";

        return $this->successResponse($message, $workshops);
    }
}