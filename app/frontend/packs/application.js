import "jquery"
window.$ = jQuery;
// global.$ = require('jquery')

// import jquery from "jquery";
// global.$ = jquery;

import 'popper.js/dist/umd/popper';
import 'bootstrap/dist/js/bootstrap';
import 'src/stylesheets/application';
import 'src/javascripts/application';
import 'src/javascripts/users';
export { default as users } from 'src/javascripts/users';


import Rails from 'rails-ujs'
Rails.start()