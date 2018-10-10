/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// import 'popper.js/dist/umd/popper';
// import 'bootstrap/dist/js/bootstrap';
// import 'src/stylesheets/application';
// import 'src/javascripts/application';
// import 'src/javascripts/users';
// export { default as users } from 'src/javascripts/users';
import 'jquery';
import '../src/stylesheets/application.scss';
import '../src/javascripts/users.js';
import Rails from 'rails-ujs';
Rails.start();
console.log('Hello World from Webpacker');

// alert('debug alert');
