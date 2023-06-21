<?php

namespace App\Jobs;

use App\Models\Booking;
use Illuminate\Support\Facades\Log;

class CancelBooking extends Job
{
    protected $booking;
    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($booking)
    {
        $this->booking = $booking;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        try {

            $bookingCode = $this->booking->booking_code;
            $booking = Booking::where('booking_code', $bookingCode)->first();
            $booking->status = 5;
            $booking->save();
            Log::info('Run for booking '. $bookingCode);

        } catch (\Exception $e) {

            // re-attempt on failure
            if ($this->attempts() > 2) {

                // manually set the job as failed on 3rd attempt and throw some error
                throw $e;
            }

            // release after 5 seconds to retry the job.
            $this->release(5);

            return;

        }
        
    }
}
