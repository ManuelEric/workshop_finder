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

class Workshop extends Model implements AuthenticatableContract, AuthorizableContract
{
    use Authenticatable, Authorizable, HasFactory;

    protected $table = 'wf_workshops';

    /**
     * The attributes that should be visible in arrays.
     *
     * @var array
     */
    protected $fillable = [
        'name',
        'email',
        'phone_number',
        'address',
        'city',
        'city_district',
        'neighbourhood',
        'suburb',
        'postcode',
        'latitude',
        'longitude',
        'opening_hours',
        'password',
        'token',
    ];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var string[]
     */
    protected $hidden = [
        'password',
    ];

    public function services()
    {
        return $this->hasMany(Services::class, 'workshop_id', 'id');
    }

    public function orders()
    {
        return $this->hasMany(Booking::class, 'workshop_id', 'id');
    }
}
