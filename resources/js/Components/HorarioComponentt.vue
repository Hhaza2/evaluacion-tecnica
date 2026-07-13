<template>
    <div class="container mt-5 mb-5" style="max-width: 800px;">
        
        <div class="card shadow p-4 border-0 mb-4">
            <h2 class="mb-4 text-center text-dark fw-bold">Asignar Horario</h2>

            <div v-if="mensaje" class="alert alert-success">{{ mensaje }}</div>
            <div v-if="errorGeneral" class="alert alert-danger">{{ errorGeneral }}</div>

            <form @submit.prevent="enviarFormulario">
                <div class="mb-3">
                    <label class="form-label text-secondary fw-semibold">Correo del docente</label>
                    <input type="email" v-model="formulario.correo_docente" @blur="buscarHorarios" class="form-control">
                    <span v-if="errores.correo_docente" class="text-danger small">{{ errores.correo_docente[0] }}</span>
                </div>

                <div class="mb-3">
                    <label class="form-label text-secondary fw-semibold">Código de la asignatura</label>
                    <input type="text" v-model="formulario.codigo_asignatura" class="form-control">
                    <span v-if="errores.codigo_asignatura" class="text-danger small">{{ errores.codigo_asignatura[0] }}</span>
                </div>

                <div class="mb-3">
                    <label class="form-label text-secondary fw-semibold">Día de la semana</label>
                    <select v-model="formulario.dia_semana" class="form-select">
                        <option value="">Seleccione un día</option>
                        <option value="Lunes">Lunes</option>
                        <option value="Martes">Martes</option>
                        <option value="Miércoles">Miércoles</option>
                        <option value="Jueves">Jueves</option>
                        <option value="Viernes">Viernes</option>
                        <option value="Sábado">Sábado</option>
                    </select>
                    <span v-if="errores.dia_semana" class="text-danger small">{{ errores.dia_semana[0] }}</span>
                </div>

                <div class="row mb-4">
                    <div class="col-md-6">
                        <label class="form-label text-secondary fw-semibold">Hora de inicio</label>
                        <input type="time" v-model="formulario.hora_inicio" class="form-control">
                        <span v-if="errores.hora_inicio" class="text-danger small">{{ errores.hora_inicio[0] }}</span>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label text-secondary fw-semibold">Hora de fin</label>
                        <input type="time" v-model="formulario.hora_fin" class="form-control">
                        <span v-if="errores.hora_fin" class="text-danger small">{{ errores.hora_fin[0] }}</span>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary w-100 fw-bold py-2">
                    Asignar Horario
                </button>
            </form>
        </div>

        <div class="card shadow p-4 border-0" v-if="listaHorarios.length > 0">
            <h4 class="mb-3 text-dark fw-bold">Horarios Asignados</h4>
            <div class="table-responsive">
                <table class="table table-hover table-bordered align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Asignatura</th>
                            <th>Día</th>
                            <th>Inicio</th>
                            <th>Fin</th>
                            <th class="text-center">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="horario in listaHorarios" :key="horario.id">
                            <td>{{ horario.asignatura }}</td>
                            <td>{{ horario.dia_semana }}</td>
                            <td>{{ horario.hora_inicio }}</td>
                            <td>{{ horario.hora_fin }}</td>
                            <td class="text-center">
                                <button @click="eliminarHorario(horario.id)" class="btn btn-danger btn-sm">
                                    Eliminar
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref } from 'vue';
import axios from 'axios';

const formulario = ref({
    correo_docente: '',
    codigo_asignatura: '',
    dia_semana: '',
    hora_inicio: '',
    hora_fin: ''
});

const errores = ref({});
const mensaje = ref('');
const errorGeneral = ref('');
const listaHorarios = ref([]);

const buscarHorarios = async () => {
    if (!formulario.value.correo_docente) return; 
    try {
        const respuesta = await axios.get(`/horarios/${formulario.value.correo_docente}`);
        listaHorarios.value = respuesta.data;
    } catch (error) {
        console.error("Error al obtener la lista de horarios:", error);
    }
};

const enviarFormulario = async () => {
    errores.value = {};
    mensaje.value = '';
    errorGeneral.value = '';

    try {
        const respuesta = await axios.post('/horarios', formulario.value);
        mensaje.value = respuesta.data.message;
        
        const correoGuardado = formulario.value.correo_docente;
        
        formulario.value = { correo_docente: correoGuardado, codigo_asignatura: '', dia_semana: '', hora_inicio: '', hora_fin: '' };
        
        buscarHorarios();
    } catch (error) {
        if (error.response && error.response.status === 422) {
            errores.value = error.response.data.errors;
        } else if (error.response && error.response.data.error) {
            errorGeneral.value = error.response.data.error;
        } else {
            errorGeneral.value = "Ocurrió un error inesperado de red.";
        }
    }
};

</script>