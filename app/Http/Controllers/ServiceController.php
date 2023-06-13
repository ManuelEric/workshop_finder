<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Traits\RestfulTrait;
use App\Models\Services;
use Exception;
use Illuminate\Database\Eloquent\ModelNotFoundException;

class ServiceController extends Controller
{
    use RestfulTrait;

    public function get($shop)
    {
        try {
            $services = Services::where('workshop_id', $shop)->get();
        } catch (ModelNotFoundException $e) {
            return $this->errorResponse("Error trying to get all services, please try again.", 400);
        }

        $message = $services->count() > 0 ? 'Services data found' : 'No data found';
        return $this->successResponse($message, $services);
    }

    public function store(Request $request)
    {
        $validated = $this->validate($request, [
            'service_type' => 'required',
            'service_price' => 'required|integer',
            'description' => 'required',
        ]);

        $serviceDetails = array_merge($validated + ['workshop_id' => $request->route('shop')]);
        
        if ($workshop = Services::create($serviceDetails))
            return $this->errorResponse("Error trying to add service, please try again.", 400);

        $message = 'Service successfully added';
        return $this->successResponse($message, $workshop);
    }

    public function update(Request $request)
    {
        $serviceId = $request->route('service');
        $validated = $this->validate($request, [
            'service_type' => 'required',
            'service_price' => 'required|integer',
            'description' => 'required',
        ]);

        try {
            $service = Services::findOrFail($serviceId);
            $service->update($validated);
        } catch (ModelNotFoundException $e) {
            return $this->errorResponse("Error trying to update service info, please try again.", 400);
        }

        $message = 'Service successfully updated';
        return $this->successResponse($message, $service);
    }

    public function destroy(Request $request)
    {
        $serviceId = $request->route('service');
        
        try {
            $service = Services::findOrFail($serviceId);
            $service->delete();
        } catch (ModelNotFoundException $e) {
            return $this->errorResponse("Error trying to remove service, please try again.", 500);
        }

        $message = 'Service successfully removed';
        return $this->successResponse($message, $service);
    }
}