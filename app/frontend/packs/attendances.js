// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
import '../src/stylesheets/application.scss';
import '../src/stylesheets/attendances.scss';
import $ from 'jquery';

const today = new Date();
let thisHour = () =>{return (`00${today.getHours()}`).slice(-2)}
let getMinutes = () =>{return (`00${today.getMinutes()}`).slice(-2)}
let changeRow = []

$(function(){
  $('button[name=syukkin]').on('click',function(){
    $(`#work_${today.getDate()}_start_4i`)[0].value = thisHour()
    $(`#work_${today.getDate()}_start_5i`)[0].value = getMinutes()
  });
  $('button[name=taikin]').on('click',function(){
    $(`#work_${today.getDate()}_end_4i`)[0].value = thisHour()
    $(`#work_${today.getDate()}_end_5i`)[0].value = getMinutes()
  });
  $('th').children('select').on('change', function(){
    // 何日目を編集したのかを取得
    changeRow.push($(this).parent().attr('name').split('_')[2])
    changeRow = changeRow.filter((x, i, self) => self.indexOf(x) === i).sort()
    console.log(changeRow)
    $('input[name=change_rows]')[0].value = changeRow
  });
});