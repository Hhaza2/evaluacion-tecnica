<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests\HorariosRequest;
use Illuminate\Support\Facades\DB;

class HorarioController extends Controller
{
    public function store(HorariosRequest $request){
        try {
            DB::statement('EXEC sp_asignar_horario ?,?,?,?,?', [
                $request->correo_docente,
                $request->codigo_asignatura,
                $request->dia_semana,
                $request->hora_inicio,
                $request->hora_fin
            ]);

            return response()->json(['message' => 'Horario asignado con exito.'], 200);
        } catch (\Exception $e){
            return response()->json(['message' => 'Error al asignar: ' . $e->getMessage()], 500);
        }
    }
}
