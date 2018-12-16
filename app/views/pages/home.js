import Vue from 'vue/dist/vue.esm'
document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        el  : '#page-home',
        data: {
            message:  gon.page,
            page   : "home?",
        }
    })
});