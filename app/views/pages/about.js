import Vue from 'vue/dist/vue.esm'
document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        el  : '#page-about',
        data: {
            message: gon.page,
            page   : "about?",
        }
    })
});