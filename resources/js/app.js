import './bootstrap';
import { createApp } from 'vue';

import HorarioComponentt from './Components/HorarioComponentt.vue';

const app = createApp({});
app.component('horario-componentt', HorarioComponentt);
app.mount('#app');
