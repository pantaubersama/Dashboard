import Vue from 'vue/dist/vue.esm'
import axios from 'axios'
import VueAxios from 'vue-axios'

Vue.use(VueAxios, axios)
Vue.axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#folderModal',
    data() {
      return {
        folder: {
          name: ""
        }
      }
    },
    methods: {
      createFolder: function (e) {
        document.getElementById('btn-create').setAttribute('disabled', 'disabled')

        var formdata = new FormData()
        formdata.append('folder[name]', this.folder.name)
        Vue.axios.post("/folders",
          formdata,
          { headers: { 'Content-Type': 'multipart/form-data' } }
        )
          .then((response) => {
            window.location = response.data.redirect_to
          })
          .catch((error) => {
            if (error.status !== 201) {
              alert(error.response.data.error)
            }
          })
      }
    }
  })
});