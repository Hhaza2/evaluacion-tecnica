<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class HorariosRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'correo_docente' => 'required|email',
            'codigo_asignatura' => 'required|string',
            'dia_semana' => 'required|string',
            'hora_inicio' => 'required|',
            'hora_fin' => 'required',
        ];
    }

    public function messages(): array{
        return [
            'correo_docente.required' => 'El correo del docente es obligatori',
            'correo_docente.email' => 'Ingrese un formato valido de correo electronico', 
            'codigo_asignatura.required' => 'El codigo de la asignatura es obligatorio',
            'dia_semana.required' => 'Debe seleccionar un dia de la semana',
            'fecha_inicio.required' => 'La fecha de inicio es obligatoria',
            'fecha_fin.required' => 'La fecha de fin es obligatoria',   
        ];
    }
}
