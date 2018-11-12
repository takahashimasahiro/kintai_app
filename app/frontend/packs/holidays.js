// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
import '../src/stylesheets/application.scss';
import '../src/stylesheets/holidays.scss';
import $ from 'jquery';

$(function(){
  $('button[name=dismiss]').on('click',function(){
    if(confirm('削除しますか？')){
      $('input[name=button]')[0].value = 'admin_applied'
      $(this).submit()
    }else{
      return false
    }
  })
  $('button[name=approve]').on('click',function(){
    $('input[name=button]')[0].value = 'apply_rejection'
    $(this).submit()
  })
})
