<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Traits\RestfulTrait;
use App\Models\Booking;
use App\Models\Services;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use App\Models\User;
use App\Models\Workshop;
use App\Models\Vehicle;

class BookingController extends Controller
{
    use RestfulTrait;
    const UNAMBIGUOUS_ALPHABET = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

    private function generateBookingCode(int $characters)
    {
        do {
            $code = $this->generateCode($characters);
        } while(Booking::where('booking_code', $code)->exists());

        return $code;
    }
    
    protected function generateCode(int $characters): string
    {
        return substr(str_shuffle(str_repeat(static::UNAMBIGUOUS_ALPHABET, $characters)), 0, $characters);
    }

    public function booking(Request $request)
    {
        $token = $request->header('token');
        $userId = User::where('token', $token)->first()->id;
        $workshopId = $request->route('workshop');
        $vehicleId = $request->vehicle;
        $serviceId = $request->service;

        try {
            $vehicle = Vehicle::findOrFail($vehicleId);
            $service = Services::findOrFail($serviceId);

        } catch (ModelNotFoundException $e) {
            return $this->errorResponse("Error while processing the booking, please try again.", 400);
        }

        $rules = [
            'booking_date' => 'required',
        ];

        $extended_rules = [];
        if ($service->service_type == "towing") {
            $extended_rules = [
                'pickup_location' => 'required',
                'pickup_latitude' => 'required',
                'pickup_longitude' => 'required',
            ];
        }

        $rules = array_merge($rules, $extended_rules);
        $validated = $this->validate($request, $rules);

        $bookingDetails = [
            'booking_code' => $this->generateBookingCode(10),
            'user_id' => $userId,
            'workshop_id' => $workshopId,
            'vehicle_id' => $vehicleId,
            'workshop_service_id' => $serviceId,
            'booking_date' => $validated['booking_date'],
            'pickup_location' => $validated['pickup_location'] ?? null,
            'pickup_latitude' => $validated['pickup_latitude'] ?? null,
            'pickup_longitude' => $validated['pickup_longitude'] ?? null,
            'price_in_total' => $service->service_price,
            'status' => 0,

        ];

        if (!$booking = Booking::create($bookingDetails))
            return $this->errorResponse('Error trying to create booking, please try again.', 500);
            
        $message = "Booking created successfully";
        return $this->successResponse($message, $booking);
    }
}