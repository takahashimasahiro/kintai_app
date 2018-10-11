var $ = require('jquery');

$(function(){
  $('select[name=year]').change(function(){
    document.getElementById('test').innerHTML = "<p>TODO:年を変えた時の処理を書く</p>"
  });
  $('select[name=month]').change(function(){
    document.getElementById('test').innerHTML = "<p>TODO:月を変えた時の処理を書く</p>"
  });
  $('input[name=syukkin]').click(function(){
    document.getElementById('test').innerHTML = "<p>TODO:出勤押した</p>"
  });
  $('input[name=taikin]').click(function(){
    document.getElementById('test').innerHTML = "<p>TODO:退勤押した</p>"
  })
  $('input[name=attend_save]').click(function(){
    document.getElementById('test').innerHTML = "<p>TODO:保存押した</p>"
  });
});

import '../src/stylesheets/users.scss';