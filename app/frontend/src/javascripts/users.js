// TODO:必要無いものは可読性向上のためerb上で書く
import "application";


const SELECTED_FIRST_YEAR = 2010;
const SELECTED_LAST_YEAR = 2030;

export default $(function(){
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
