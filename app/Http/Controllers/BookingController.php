<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Traits\RestfulTrait;
use App\Jobs\CancelBooking;
use App\Models\Booking;
use App\Models\Services;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use App\Models\User;
use App\Models\Workshop;
use App\Models\Vehicle;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Queue;

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

    public function get(Request $request)
    {
        $token = $request->header('token');
        $user = User::where('token', $token)->firstOrFail();
        if ($user->bookings()->count() == 0 ) {
            $message = "You haven't booked before.";
            return $this->successResponse($message, []);
        }

        $status = $request->route('old') != true ? [0,1,2] : [3,4];
        
        $index = 0;
        foreach ($user->bookings as $booking) {
            $response[$index] = [
                'booking_code' => $booking->booking_code,
                'user_id' => $booking->user_id,
                'workshop_id' => $booking->workshop_id,
                'vehicle_id' => $booking->vehicle_id,
                'workshop_service_id' => $booking->workshop_service_id,
                'booking_date' => $booking->booking_date,
                'pickup_location' => $booking->pickup_location,
                'pickup_latitude' => $booking->pickup_latitude,
                'pickup_longitude' => $booking->pickup_longitude,
                'price_in_total' => $booking->price_in_total,
                'status' => $booking->status,
                'proof_of_payment' => $booking->proof_of_payment,
                'queue_id' => $booking->queue_id,
                'created_at' => $booking->created_at,
                'updated_at' => $booking->updated_at,
                'workshop' => $booking->workshop,
                'user' => $booking->user
            ];

            $serviceId = $booking->workshop_service_id;
            $vehicleId = $booking->vehicle_id;

            $response[$index]['workshop']['services'] = $booking->workshop->services()->where('id', $serviceId)->get();
            $response[$index]['user']['vehicles'] = $booking->user->vehicles()->where('id', $vehicleId)->get();
            $index++;
        }


        $bookings = $user->bookings()->with(['workshop', 'workshop.services', 'user', 'user.vehicles'])->whereIn('status', $status)->get();

        $message = "Booked history found.";
        return $this->successResponse($message, $response);
    }

    public function show(Request $request)
    {
        $bookingCode = $request->route('booking');
        $token = $request->header('token');
        $user = User::where('token', $token)->firstOrFail();
        if ($user->bookings()->count() == 0 ) {
            $message = "You haven't booked before.";
            return $this->successResponse($message, []);
        }

        $booking = Booking::where('booking_code', $bookingCode)->first();
        $serviceId = $booking->workshop_service_id;
        $vehicleId = $booking->vehicle_id;

        $show = Booking::withAndWhereHas('workshop.services', function ($subQuery) use ($serviceId) {
            $subQuery->where('id', $serviceId);
        })->
        withAndWhereHas('user.vehicles', function ($subQuery) use ($vehicleId) {
            $subQuery->where('id', $vehicleId);
        })->
        where('booking_code', $bookingCode)->first();
        $message = "Booked history found.";
        return $this->successResponse($message, $show);
    }

    public function booking(Request $request)
    {
        $token = $request->header('token');
        $userId = User::where('token', $token)->firstOrFail()->id;
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
                'pickup_location' => 'nullable',
                'pickup_latitude' => 'nullable',
                'pickup_longitude' => 'nullable',
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

        $booking = Booking::withAndWhereHas('workshop', function ($subQuery) use ($serviceId) {
                $subQuery->withAndWhereHas('services', function ($subQuery_2) use ($serviceId) {
                    $subQuery_2->where('id', $serviceId);
                });
            })->where('booking_code', $booking->booking_code)->
            withAndWhereHas('user', function ($subQuery) use ($vehicleId) {
                $subQuery->withAndWhereHas('vehicles', function ($subQuery_2) use ($vehicleId) {
                    $subQuery_2->where('id', $vehicleId);
                });
            })->
            first();

        $queueId = Queue::later(Carbon::now()->addMinutes(20), new CancelBooking($booking));
        
        $booking->queue_id = $queueId;
        $booking->save();

        $message = "Booking created successfully";
        return $this->successResponse($message, $booking);
    }

    public function upload(Request $request)
    {
        $token = $request->header('token');
        $user = User::where('token', $token)->firstOrFail();
        $bookingCode = $request->route('booking');
        $currentBooking = $user->bookings()->where('booking_code', $bookingCode)->firstOrFail();
        $currentProofImg = $currentBooking->proof_of_payment;

        $this->validate($request, [
            'proof' => 'required|mimes:png,jpg',
        ]);

        $currentProofPath = base_path('payment') .'/'.$currentProofImg;
        if (file_exists($currentProofPath))
            unlink($currentProofPath);

        $uploadedProof = $request->file('proof');
        $paymentDetail['proof_of_payment'] = date('Ymd').'_'.$bookingCode.'_'.Str::random(10).".".$uploadedProof->extension();

        $uploadedProof->move(base_path('public/payment'), $paymentDetail['proof_of_payment']);

        try {
            $currentBooking->proof_of_payment = $paymentDetail['proof_of_payment'];
            $currentBooking->status = 1;
            $currentBooking->save();

            DB::table('jobs')->where('id', $currentBooking->queue_id)->delete();

        } catch (ModelNotFoundException $e) {
            return $this->errorResponse('Error trying to upload proof of payment, please try again.', 400);
        }

        $message = "Success upload proof of payment.";
        return $this->successResponse($message, $currentBooking);
    }

    public function view(Request $request)
    {
        $image = $request->route('image');
        $exp = explode("_", $image);
        $bookingCode = $exp[1];

        return base_path('/').Booking::where('booking_code', $bookingCode)->first()->proof_of_payment;
    }

    public function cancel(Request $request)
    {
        $token = $request->header('token');
        $user = User::where('token', $token)->firstOrFail();
        $bookingCode = $request->route('booking');

        $booking = Booking::with(['workshop', 'workshop.services', 'user', 'user.vehicles'])->where('booking_code', $bookingCode)->firstOrFail();

        if (!$booking->exists())
            return $this->errorResponse('The booking doesn\'t exist.', 400);

        if (!$user->bookings()->where('booking_code', $bookingCode)->exists())
            return $this->errorResponse('You don\'t have permission to cancel this booking.', 200);

        if (!$booking->update(['status' => 4]))
            return $this->errorResponse('Error trying to cancel the booking, please try again.', 400);

        $message = "Your booking has been cancelled";
        return $this->successResponse($message, $booking);
        
    }
}