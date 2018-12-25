// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
import '../src/stylesheets/application.scss';
import '../src/stylesheets/attendances.scss';
import 'jquery-ui/ui/widgets/dialog'
import $ from 'jquery';

const today = new Date();
const thisHour = () => { return (`00${today.getHours()}`).slice(-2) }
const getMinutes = () => { return (`00${today.getMinutes()}`).slice(-2) }

$(function () {
  // 出勤ボタン押下
  $('button[name=syukkin]').on('click', () => {
    $(`#work_${today.getDate()}_start_4i`)[0].value = thisHour()
    $(`#work_${today.getDate()}_start_5i`)[0].value = getMinutes()
    changeRowData(today.getDate())
  });
  // 退勤ボタン押下
  $('button[name=taikin]').on('click', () => {
    $(`#work_${today.getDate()}_end_4i`)[0].value = thisHour()
    $(`#work_${today.getDate()}_end_5i`)[0].value = getMinutes()
    changeRowData(today.getDate())
  });
  // selectタグの値変更
  $('th').children('select').on('change', function () {
    var selectRow = Number($(this).parent().attr('name').split('_')[2])
    changeRowData(selectRow)
    $('#save-button').submit()
    // TODO: statusがvacationになった時理由を入力させるダイアログを表示
    // if ($(`select[name=status_${selectRow}]`)[0].value.indexOf('vacation') !=-1 ) {
    // }else{
    // }
  });
});

// 休暇理由を入力してsave
function applyForLeave(reason){
  if (reason != ""){
    $('input[name=vacation_reason]')[0].value = reason
  }
  var selectRow = Number($(this).parent().attr('name').split('_')[2])
  changeRowData(selectRow)
  $('#save-button').submit()
}

function changeRowData(row) {
  $('input[name=change_day]')[0].value = row
  $('input[name=change_start_hour]')[0].value = $(`#work_${row}_start_4i`)[0].value
  $('input[name=change_start_minute]')[0].value = $(`#work_${row}_start_5i`)[0].value
  $('input[name=change_end_hour]')[0].value = $(`#work_${row}_end_4i`)[0].value
  $('input[name=change_end_minute]')[0].value = $(`#work_${row}_end_5i`)[0].value
  $('input[name=change_status]')[0].value = $(`#status_${row}`)[0].value
}