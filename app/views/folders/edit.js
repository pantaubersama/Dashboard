import Vue from 'vue/dist/vue.esm'
import axios from 'axios'
import VueAxios from 'vue-axios'

Vue.use(VueAxios, axios)
Vue.axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#editFolderModal',
    data() {
      return {
        folder: {
          name: ""
        },
        id: document.querySelector('#editFolder').value,
      }
    },

    mounted() {
      Vue.axios.get("/folders/" + this.id + "/edit").
        then(response => {
          this.folder = response.data.folder
        })
    },

    methods: {
      updateFolder: function (e) {
        document.getElementById('btn-update').setAttribute('disabled', 'disabled')

        var formdata = new FormData()
        formdata.append('folder[name]', this.folder.name)
        Vue.axios.put("/folders/" + this.id,
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