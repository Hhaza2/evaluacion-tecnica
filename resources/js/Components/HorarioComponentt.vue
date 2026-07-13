<template>
<div class="container mt-5" style="max-width: 600px;">
    <div class="card" shadow p-4 border-0>
        <h2 class="mb-4 text-center text-dark fw-bold">
            Asignar Horario a Docente
        </h2>

        <div v-if="mensaje" class="alert alert-success">
            {{mensaje}}
        </div>
        <div v-if="errorGeneral" class="alert alert-danger">
            {{errorGeneral}}
        </div>

        <form @submit.prevent="enviarFormulario">
            <div class="mb-3">
                <label class="form-label text-secondary fw-semibold">Correo del docente </label>
                <input type="email" v-model="formulario.correo_docente" class="form-control">
                <span v-if="errores.correo_docente" class="text-danger small">{{errores.correo_docente}}</span>
            </div> 
            <div class="mb-3">
                <label class="form-label text-secondary fw-semibold">Codigo asignatura </label>
                <input type="text" v-model="formulario.codigo_asignatura" class="form-control">
                <span v-if="errores.codigo_asignatura" class="text-danger small">{{errores.codigo_asignatura}}</span>
            </div>             
            <div class="mb-3">
                <label class="form-label text-secondary fw-semibold">Dia de la semana</label>
                <select v-model="formulario.dia_semana" class="form-select">
                    <option value="Lunes">Lunes</option>
                    <option value="Martes">Martes</option>
                    <option value="Miercoles">Miercoles</option>
                    <option value="Jueves">Jueves</option>
                    <option value="Viernes">Viernes</option>
                    <option value="Sabado">Sabado</option>
                </select>
                <span v-if="errores.dia_semana" class="text-danger small">{{errores.dia_semana}}</span>
            </div>    
            <div class="row mb-4">         
                <div class="col-md-6">
                    <label class="form-label text-secondary fw-semibold">Hora de inicio </label>
                    <input type="time" v-model="formulario.hora_inicio" class="form-control">
                    <span v-if="errores.hora_inicio" class="text-danger small">{{errores.hora_inicio}}</span>
                </div>             
                <div class="col-md-6">
                    <label class="form-label text-secondary fw-semibold">Hora de fin </label>
                    <input type="time" v-model="formulario.hora_fin" class="form-control">
                    <span v-if="errores.hora_fin" class="text-danger small">{{errores.hora_fin}}</span>
                </div> 
            </div>

            <button type="submit" class="btn btn-primary w-100 fw-bold py-2">
                Asignar Horario
            </button>
        </form>
    </div>
</div>
</template>


<script setup>

import {ref} from 'vue';
import axios from 'axios';

const formulario = ref({
    correo_docente: '',
    codigo_asignatura: '',
    dia_semana: '',
    hora_inicio: '',
    hora_fin:''
});

const errores = ref({});
const mensaje = ref('');
const errorGeneral = ref('');

const enviarFormulario= async () => {
    errores.value = {};
    mensaje.value = '';
    errorGeneral.value = '';

    try {
        const respuesta = await axios.post('/horarios', formulario.value);
        mensaje.value = respuesta.data.message;
        formulario.value = {correo_docente: '', codigo_asignatura: '', dia_semana:'', hora_inicio:'', hora_fin:''};

    }catch(error){
        if(error.response && error.response.status === 422){
            errores.value = error.response.data.errors;
        }else if(error.response && error.response.data.error){
            errorGeneral.value = error.response.data.errors;
        }else{
            errorGeneral.value = "Ocurrio un error inesperado de red"
        }
    }
}
</script>