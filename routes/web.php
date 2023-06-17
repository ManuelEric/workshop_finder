<?php

/** @var \Laravel\Lumen\Routing\Router $router */

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->get('/', function () use ($router) {
    return $router->app->version();
});

$router->get('public/{image}', ['uses' => 'BookingController@view']);

$router->group(['prefix' => 'api'], function () use ($router) {
    
    // Authentication for User
    $router->post('register', ['uses' => 'UserController@register']);
    $router->post('login', ['uses' => 'UserController@login']);
    
    $router->group(['middleware' => 'auth'], function () use ($router) {
        // User
        $router->get('user[/{user}]', ['uses' => 'UserController@get']);
        $router->put('user/{user}/edit/profile', ['uses' => 'UserController@update']);
        $router->post('user/{user}/find/workshops', ['uses' => 'UserController@find']);
        // Booking
        $router->get('book/history', ['uses' => 'BookingController@get']);
        $router->get('book/{booking}', ['uses' => 'BookingController@show']);
        $router->post('book/workshop/{workshop}', ['uses' => 'BookingController@booking']);
        $router->post('book/{booking}/payment/confirm', ['uses' => 'BookingController@upload']);
        $router->put('book/{booking}/cancel', ['uses' => 'BookingController@cancel']);
        
        // Vehicle
        $router->get('user/{user}/vehicle', ['uses' => 'VehicleController@get']);
        $router->post('user/{user}/add/vehicle', ['uses' => 'VehicleController@store']);
        $router->put('user/{user}/edit/vehicle/{vehicle}', ['uses' => 'VehicleController@update']);
        $router->delete('user/{user}/remove/vehicle/{vehicle}', ['uses' => 'VehicleController@destroy']);
    });

    $router->group(['prefix' => 'ws'], function () use ($router) {
        
        // Authentication for Workshop
        $router->post('register', ['uses' => 'WorkshopController@register']);
        $router->post('login', ['uses' => 'WorkshopController@login']);

        $router->group(['middleware' => 'auth'], function () use ($router) {
            // Workshop
            $router->get('shop[/{shop}]', ['uses' => 'WorkshopController@get']);
            $router->put('shop/{shop}/edit/profile', ['uses' => 'WorkshopController@update']);

            // Services
            $router->get('shop/{shop}/services', ['uses' => 'ServiceController@get']);
            $router->post('shop/{shop}/add/service', ['uses' => 'ServiceController@store']);
            $router->put('shop/{shop}/edit/service/{service}', ['uses' => 'ServiceController@update']);
            $router->delete('shop/{shop}/remove/service/{service}', ['uses' => 'ServiceController@destroy']);
        });
    });

});