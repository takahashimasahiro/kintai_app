var $ = require('jquery');

$(function(){
  $('select[name=year]').change(function(){
    document.getElementById('test').innerHTML = "<p>TODO:年を変えた時の処理を書く</p>"
  });
  $('select[name=month]').change(function(){
    document.getElementById('test').innerHTML = "<p>TODO:月を変えた時の処理を書く</p>"
  });
  $('input[name=syukkin]').click(function(){
    var today = new Date();
    document.getElementsByName('work_start_'+ today.getDate())[0].value= today.getHours()  + ":" + today.getMinutes()
  });
  $('input[name=taikin]').click(function(){
    var today = new Date();
    document.getElementsByName('work_end_'+ today.getDate())[0].value= today.getHours() + ":" + today.getMinutes()
  })
  $('input[name=attend_save]').click(function(){
    document.getElementById('test').innerHTML = "<p>TODO:保存押した</p>"
  });
});
import '../src/stylesheets/users.scss';