<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\TourController;
use App\Http\Controllers\UserController;

Route::get('/test', function () {
    return response()->json(['message' => 'API жұмыс істеп тұр!']);
});

Route::get('/tours', [TourController::class, 'index']);
Route::get('/tours/{id}', [TourController::class, 'show']);
Route::middleware('auth:sanctum')->get('/user', [UserController::class, 'index']);