// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
import '../src/stylesheets/application.scss';
import '../src/stylesheets/operation_log.scss';
import $ from 'jquery';

$(function () {
  $("#nav1").on('click', () => {
    $("#nav2").removeClass("active")
    $("#tab2").removeClass("active")
    $("#nav1").addClass("active")
    $("#tab1").addClass("active")
  })
  $("#nav2").on('click', () => {
    $("#nav1").removeClass("active")
    $("#tab1").removeClass("active")
    $("#nav2").addClass("active")
    $("#tab2").addClass("active")
  })
});