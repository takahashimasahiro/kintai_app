import "jquery"
global.$ = require('jquery')

import 'popper.js/dist/umd/popper';
import 'bootstrap/dist/js/bootstrap';
import 'src/stylesheets/application'

import Rails from 'rails-ujs'
Rails.start()