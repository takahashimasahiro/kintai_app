import '../src/stylesheets/users.scss';
var $ = require('jquery');
const today = new Date();
var thisHour = () =>{
  return (`00${today.getHours()}`).slice(-2)
}
var getMinutes = () =>{
  return (`00${today.getMinutes()}`).slice(-2)
}

$(function(){
  $('button[name=syukkin]').click(function(){
    document.getElementsByName(`work_${today.getDate()}[start(4i)]`)[0].value = thisHour()
    document.getElementsByName(`work_${today.getDate()}[start(5i)]`)[0].value = getMinutes()
  });
  $('button[name=taikin]').click(function(){
    document.getElementsByName(`work_${today.getDate()}[end(4i)]`)[0].value = thisHour()
    document.getElementsByName(`work_${today.getDate()}[end(5i)]`)[0].value = getMinutes()
  })
});
