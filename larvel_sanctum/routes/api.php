<?php

use App\Http\Controllers\Auth\TokenController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;


Route::group(['middleware' => 'auth:sanctum'], function () {
    Route::get('/user', function (Request $request) {
        return $request->user();
    });

    Route::get('/user/posts', function (Request $request) {
        return $request->user()->posts;
    });

    Route::delete('/auth/token', [TokenController::class, 'destroy']);
});


Route::post('/auth/token', [TokenController::class, 'store']);

// Route::delete('/auth/token', [TokenController::class, 'destroy'])->middleware('auth:sanctum');

