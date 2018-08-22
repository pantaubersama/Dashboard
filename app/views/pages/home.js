import TurbolinksAdapter from 'vue-turbolinks';
import Vue from 'vue/dist/vue.esm'

//import App from '../app.vue'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
    const app = new Vue({
        el  : '#home',
        data: {
            message: gon.home,
            room   : "room?",
        }
        // components: { App }
    })
})