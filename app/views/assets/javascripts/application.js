/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

console.log('Hello Dashboard');
import '../stylesheets/application.scss'
import 'jquery'
import 'bootstrap'
import './select_ajax'
import './question'
import './main'
// import './modernizr'
import '@fortawesome/fontawesome-free/js/all.js'
import Rails from 'rails-ujs'

// Select2
require("select2/dist/css/select2")
require("select2-bootstrap-theme/dist/select2-bootstrap")
import Select2 from "select2"
$.fn.select2.defaults.set("theme", "bootstrap")

Rails.start();