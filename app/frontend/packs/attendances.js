// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
import '../src/stylesheets/application.scss';
import '../src/stylesheets/attendances.scss';
import $  from 'jquery';

const today = new Date();
let thisHour = () =>{return (`00${today.getHours()}`).slice(-2)}
let getMinutes = () =>{return (`00${today.getMinutes()}`).slice(-2)}

$(function(){
  $('button[name=syukkin]').on('click',function(){
    $(`#work_${today.getDate()}_start_4i`)[0].value = thisHour()
    $(`#work_${today.getDate()}_start_5i`)[0].value = getMinutes()
  });
  $('button[name=taikin]').on('click',function(){
    $(`#work_${today.getDate()}_end_4i`)[0].value = thisHour()
    $(`#work_${today.getDate()}_end_5i`)[0].value = getMinutes()
  });
  $('button[name=attend_save]').on('click',function(){
    
    // $.ajax({
    //   url: '2',
    //   type: 'patch',
    //   data: {select_year: 2010,
    //     select_month: 10},
    //   dataType: 'html',
    //   success: function(data){
    //     console.log('success')
    //   },
    //   error: function(data){
    //     console.log('error')
    //   }
    // })
    
    //  テーブルから必要なものをまとめる
    // let workTime =[]
    // for(let i = 1;i < document.getElementById('attendance-table').rows.length ;i++){
    // }
  });
});