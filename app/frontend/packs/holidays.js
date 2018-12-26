// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
import '../src/stylesheets/application.scss';
import '../src/stylesheets/holidays.scss';
import $ from 'jquery';

$(function () {
  $('button[name=dismiss]').on('click', function () {
    if (confirm('却下しますか？')) {
      let row = $(this).parent().parent()[0].className
      $(`input[class=button_${row}]`)[0].value ='apply_rejection'
      addComment(row, $(`tr[class=${row}]`).children('th').children('input[name=owner-comment]')[0].value)
    } else {
      return false
    }
  })
  $('button[name=approve]').on('click', function () {
    let row = $(this).parent().parent()[0].className
    $(`input[class=button_${$(this).parent().parent()[0].className}]`)[0].value ='admin_applied'
    addComment(row, $(`tr[class=${row}]`).children('th').children('input[name=owner-comment]')[0].value)
  })
  $('input[name=owner-comment]').on('change', function(){
    addComment($(this).parent().parent()[0].className, $(this)[0].value)
  })
})
function addComment(row, val){
  $(`input[class=comment_${row}]`)[0].value = val
}
