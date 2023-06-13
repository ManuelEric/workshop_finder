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

class Services extends Model
{
    use HasFactory;

    protected $table = 'wf_workshop_services';

    /**
     * The attributes that should be visible in arrays.
     *
     * @var array
     */
    protected $fillable = [
        'workshop_id',
        'service_type',
        'service_price',
        'description',
    ];

    public function workshop()
    {
        return $this->belongsTo(Workshop::class, 'workshop_id', 'id');
    }

    public function orders()
    {
        return $this->hasMany(Booking::class, 'workshop_service_id', 'id');
    }
}
