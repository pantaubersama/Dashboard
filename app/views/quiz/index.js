import Vue from 'vue/dist/vue.esm'
import axios from 'axios'
import VueAxios from 'vue-axios'
import { VueEditor } from 'vue2-editor'

Vue.use(VueAxios, axios)
Vue.axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#quizModal',
    components: {
      VueEditor
    },
    data() {
      return {
        CustomToolbar: [
          ['bold', 'italic', 'underline'],
          [{ 'list': 'ordered' }, { 'list': 'bullet' }],
          [{ 'align': [] }]
        ],
        counter: 1,
        quiz: {
          title: "",
          description: "",
          image: "",
          status: "draft",
          questions: [{ content: "" }],
          answers: [{ team_1_answer: "", team_2_answer: "" }]
        }
      }
    },
    methods: {
      addQuestion: function (event) {
        var question = {
          content: ""
        }
        this.quiz.questions.push(question)

        var answer = {
          team_1_answer: "",
          team_2_answer: ""
        }
        this.quiz.answers.push(answer)

        this.counter += 1
      },
      removeQuestion: function (id) {
        this.quiz.questions.splice(id, 1)
        this.quiz.answers.splice(id, 1)
        this.counter -= 1
      },
      onFileChange: function (e) {
        var files = e.target.files || e.dataTransfer.files;
        if (!files.length)
          return;
        this.quiz.image = files[0]
      },
      createQuiz: function (e) {
        var formdata = new FormData()
        formdata.append('quiz[title]', this.quiz.title)
        formdata.append('quiz[description]', this.quiz.description)
        formdata.append('quiz[image]', this.quiz.image)
        formdata.append('quiz[status]', this.quiz.status)
        this.quiz.questions.forEach(function (item, index) {
          formdata.append('quiz[questions][][content]', item.content)
        })
        this.quiz.answers.forEach(function (item, index) {
          formdata.append('quiz[answers][][team_1_answer]', item.team_1_answer)
          formdata.append('quiz[answers][][team_2_answer]', item.team_2_answer)
        })
        Vue.axios.post("/quiz",
          formdata,
          { headers: { 'Content-Type': 'multipart/form-data' } }
        )
          .then((response) => {
            // $("#quizModal .close").click()
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