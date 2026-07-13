<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests\HorariosRequest;
use Illuminate\Support\Facades\DB;

class HorarioController extends Controller
{

    public function show($correo)
    {
        $horarios = DB::table('horarios')
            ->join('docentes', 'horarios.id_docente', '=', 'docentes.id')
            ->join('asignaturas', 'horarios.id_asignatura', '=', 'asignaturas.id')
            ->where('docentes.correo', $correo)
            ->select('horarios.id', 'asignaturas.nombre as asignatura', 'horarios.dia_semana', 'horarios.hora_inicio', 'horarios.hora_fin')
            ->get();

        return response()->json($horarios);
    }

    public function destroy($id)
    {
        try {
            DB::table('horarios')->where('id', $id)->delete();
            return response()->json(['message' => 'Horario eliminado con exito.']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Error al eliminar: ' . $e->getMessage()], 500);
        }
    }
}
