<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Traits\RestfulTrait;
use App\Models\Vehicle;
use Exception;

class VehicleController extends Controller
{
    use RestfulTrait;

    public function get($user)
    {
        try {
            $vehicles = Vehicle::where('user_id', $user)->get();
        } catch (Exception $e) {
            return $this->errorResponse($e->getMessage());
        }

        $message = $vehicles->count() > 0 ? 'Vehicle data found' : 'No data found';
        return $this->successResponse($message, $vehicles);
    }

    public function store(Request $request)
    {
        $validated = $this->validate($request, [
            'brand' => 'required',
            'type' => 'required',
            'number_plate' => 'required|unique:wf_user_vehicles,number_plate',
            'color' => 'nullable',
        ]);

        $vehicleDetails = array_merge($validated + ['user_id' => $request->route('user')]);
        
        try {
            $vehicle = Vehicle::create($vehicleDetails);
        } catch (Exception $e) {
            return $this->errorResponse($e->getMessage());
        }

        $message = 'Vehicle successfully added';
        return $this->successResponse($message, $vehicle);
    }

    public function update(Request $request)
    {
        $vehicleId = $request->route('vehicle');
        $validated = $this->validate($request, [
            'brand' => 'required',
            'type' => 'required',
            'number_plate' => 'required|unique:wf_user_vehicles,number_plate,'.$vehicleId,
            'color' => 'nullable',
        ]);

        try {
            $vehicle = Vehicle::find($vehicleId);
            $vehicle->update($validated);
        } catch (Exception $e) {
            return $this->errorResponse($e->getMessage());
        }

        $message = 'Vehicle successfully updated';
        return $this->successResponse($message, $vehicle);
    }

    public function destroy(Request $request)
    {
        $vehicleId = $request->route('vehicle');
        
        try {
            $vehicle = Vehicle::find($vehicleId);
            $vehicle->delete();
        } catch (Exception $e) {
            return $this->errorResponse($e->getMessage());
        }

        $message = 'Vehicle successfully removed';
        return $this->successResponse($message, $vehicle);
    }
}