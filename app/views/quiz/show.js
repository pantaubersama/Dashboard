import Vue from 'vue/dist/vue.esm'
import axios from 'axios'
import VueAxios from 'vue-axios'
import { VueEditor } from 'vue2-editor'

Vue.use(VueAxios, axios)
Vue.axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#editQuiz',
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
        id: document.querySelector('#editQuiz').getAttribute('data-quiz-id'),
        counter: 0,
        counter_for_new: 0,
        quiz: {
          title: "",
          description: "",
          image: "",
          status: "draft",
        },
        imagePreview: "",
        questions: [],
        deleted_questions: [],
        new_questions: []
      }
    },

    mounted() {
      Vue.axios.get("/quiz/" + this.id + "/edit").
        then(response => {
          this.quiz = response.data.quiz
          this.questions = response.data.questions
          this.counter = response.data.questions.length
        })
    },

    methods: {
      onFileChange: function (e) {
        var files = e.target.files || e.dataTransfer.files;
        if (!files.length)
          return;
        this.imagePreview = files[0]
      },

      removeQuestion: function (id) {
        var item = this.questions[id]
        this.deleted_questions.push(item.id)
        this.questions.splice(id, 1)
        this.counter -= 1
      },

      addQuestion: function (event) {
        var question = {
          content: "",
          team_1_answer: "",
          team_2_answer: ""
        }
        this.new_questions.push(question)
        this.counter_for_new += 1
      },

      removeNewQuestion: function (id) {
        this.new_questions.splice(id, 1)
        this.counter_for_new -= 1
      },

      updateQuiz: function (e) {
        document.getElementById('btn-update').setAttribute('disabled', 'disabled')
        var formdata = new FormData()
        formdata.append('quiz[id]', this.id)
        formdata.append('quiz[title]', this.quiz.title)
        formdata.append('quiz[description]', this.quiz.description)
        formdata.append('quiz[image]', this.imagePreview)
        formdata.append('quiz[status]', this.quiz.status)
        this.questions.forEach(function (item, index) {
          formdata.append('existing_question[question][][id]', item.id)
          formdata.append('existing_question[question][][content]', item.content)
          formdata.append('existing_question[question][][team_1_answer]', item.answers.find(o => o.team === 1).content)
          formdata.append('existing_question[question][][team_2_answer]', item.answers.find(o => o.team === 2).content)
        })
        this.deleted_questions.forEach(function (item, index) {
          formdata.append('deleted_questions[question][]', item)
        })
        this.new_questions.forEach(function (item, index) {
          formdata.append('new_questions[question][][content]', item.content)
          formdata.append('new_questions[question][][team_1_answer]', item.team_1_answer)
          formdata.append('new_questions[question][][team_2_answer]', item.team_2_answer)
        })
        formdata.append('new_questions[total]', this.counter_for_new)
        Vue.axios.put("/quiz/" + this.id,
          formdata,
          { headers: { 'Content-Type': 'multipart/form-data' } }
        ).then((response) => {
          console.log(response)
          window.location = response.data.redirect_to
        }).catch((error) => {
          if (error.status !== 201) {
            alert(error.response.data.error)
          }
        })
      }
    }
  })
});