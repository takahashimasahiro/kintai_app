const SELECTED_FIRST_YEAR = 2010;
const SELECTED_LAST_YEAR = 2030;

$(function(){
  var today = new Date()
  var selectDay = new Date()
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
  selectDay.setFullYear(today.getFullYear())
  selectDay.setMinutes(today.getMonth())
  document.getElementById('pulldown').innerHTML = PulldownYear(today) + PulldownMonth(today)
  document.getElementById('attendance-table').innerHTML = CreateAttendanceTable(selectDay)
});

function CreateAttendanceTable(selectDay){
  return "<table class='table table-bordered' >" + SetAttendanceTableContents(selectDay) + "</table>"
}

function SetAttendanceTableContents(selectDay){
  return SetAttendanceTableHeader() + SetAttendanceTableRows(selectDay)
}

function SetAttendanceTableHeader(){
  return "<tr><th>日付</th><th>曜日</th><th>出勤時間</th><th>退勤時間</th><th>状況</th></tr>"
}

function SetAttendanceTableRows(selectDay){
  var rows =""
  const dateofweek = ["日","月","火","水","木","金","土"]
  let enddate = new Date(selectDay.getFullYear(),selectDay.getMonth()+1,0).getDate()
  for(var i = 0 ; i < enddate ; i++){
    rows += '<tr><th>' + Number(i + 1) + '</th>'
    rows += "<th>" + dateofweek[new Date(selectDay.getFullYear(),selectDay.getMonth(),i).getDay()] +"</th>"
    rows += "<th>" + GetAttendanceTime() + "</th>"
    rows += "<th>" + GetWorkEndTime() + "</th>"
    rows += "<th>" + GetAttendanceStatus() + "</th></tr>"
  }
  return rows
}

function GetAttendanceTime(){
  return "00:00"
}
function GetWorkEndTime(){
  return "00:00"
}
function GetAttendanceStatus(){
  return "出勤"
}

function PulldownYear(today){
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

function PulldownMonth(today){
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