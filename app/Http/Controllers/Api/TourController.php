<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Tour;
use Illuminate\Http\Request;

class TourController extends Controller
{
    public function index()
    {
        return response()->json(Tour::all(), 200);
    }

    public function show($id)
    {
        $tour = Tour::find($id);

        if (!$tour) {
            return response()->json(['message' => 'Тур табылмады'], 404);
        }

        return response()->json($tour, 200);
    }
}

