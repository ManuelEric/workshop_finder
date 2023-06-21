<?php

namespace App\Models;

use Illuminate\Contracts\Auth\Access\Authorizable as AuthorizableContract;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Auth\Authenticatable;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Collection;
use Laravel\Lumen\Auth\Authorizable;

class Booking extends Model
{
    use HasFactory;

    protected $table = 'wf_bookings';

    protected $primaryKey = 'booking_code';
    public $incrementing = false;

    /**
     * The attributes that should be visible in arrays.
     *
     * @var array
     */
    protected $fillable = [
        'booking_code',
        'user_id',
        'workshop_id',
        'vehicle_id',
        'workshop_service_id',
        'booking_date',
        'pickup_location',
        'pickup_latitude',
        'pickup_longitude',
        'price_in_total',
        'status',
        'proof_of_payment',
        'queue_id',
    ];

    public function scopeWithAndWhereHas($query, $relation, $constraint){
        return $query->whereHas($relation, $constraint)
                     ->with([$relation => $constraint]);
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }

    public function workshop()
    {
        return $this->belongsTo(Workshop::class, 'workshop_id', 'id');
    }
}
