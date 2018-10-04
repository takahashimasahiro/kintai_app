
const SELECTED_FIRST_YEAR = 2010;
const SELECTED_LAST_YEAR = 2030;

$(function(){
  var today = new Date()
  document.getElementById('date').innerHTML = pulldownYear(today) + pulldownMonth(today)

  $('select[name=year]').change(function(){
    document.getElementById('test').innerHTML = "<p>TODO:年を変えた時の処理を書く</p>"
  });
  
  $('select[name=month]').change(function(){
    document.getElementById('test').innerHTML = "<p>TODO:月を変えた時の処理を書く</p>"    
  });
});

function pulldownYear(today){
  var html = "<select  name=\"" + "year" + "\" class=\"" + "pulldown-year" + "\">"
  for(var i=SELECTED_FIRST_YEAR ; i < SELECTED_LAST_YEAR ;i++){
    html += "<Option value= \"" + i + "\"" 
    if(i== today.getFullYear()){
      html += " selected"
    }
    html += ">" + i + "</Option>"
  }
  html += "</select>" + "年"
  return html
}

function pulldownMonth(today){
  var html = "<select name=\"" + "month" + "\" class=\"" + "pulldown-month" + "\">" 
  for(var i=1 ;i<=12 ;i++){
    html += "<Option value= \"" + i + "\""
    if(i== today.getMonth()+1){
      html += " selected"
    }
    html += ">" + i + "</Option>"
  } 
  html += "</select>"+"月"
  return html
}