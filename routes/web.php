<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HorarioController;

Route::get('/', function () {
    return view('welcome');
});

Route::post('/horarios', [HorarioController::class, 'store']);