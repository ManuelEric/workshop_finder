<?php 

namespace App\Http\Traits;

trait RestfulTrait {
    
    public function errorResponse($message, $code = null) 
    {
        $response = [
            'success' => false,
            'message' => $message
        ];

        return response()->json($response, $code);
    }

    public function successResponse($message, $data) 
    {
        $response = [
            'success' => true,
            'message' => $message,
            'data' => $data
        ];

        return response()->json($response);
    }

}