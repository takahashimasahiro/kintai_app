// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
import '../src/stylesheets/application.scss';
import '../src/stylesheets/attendances.scss';
import 'jquery-ui/ui/widgets/dialog'
import $ from 'jquery';

const today = new Date();
const thisHour = () => { return (`00${today.getHours()}`).slice(-2) }
const getMinutes = () => { return (`00${today.getMinutes()}`).slice(-2) }
var selectRow

$(function () {
  // 出勤ボタン押下
  $('button[name=syukkin]').on('click', () => {
    $(`#work_${today.getDate()}_start_4i`)[0].value = thisHour()
    $(`#work_${today.getDate()}_start_5i`)[0].value = getMinutes()
    changeRowData(today.getDate())
    $('#save-button').submit()
  });
  // 退勤ボタン押下
  $('button[name=taikin]').on('click', () => {
    $(`#work_${today.getDate()}_end_4i`)[0].value = thisHour()
    $(`#work_${today.getDate()}_end_5i`)[0].value = getMinutes()
    changeRowData(today.getDate())
    $('#save-button').submit()
  });
  // 出勤時間変更
  $('.start_work').children('select').on('change', function () {
    selectRow = Number($(this).parent().attr('name').split('_')[2])
    changeWorkStatus(selectRow, $(`#status_${selectRow}`).parent().parent().attr('class').split(' ')[1].split('_')[3])
    changeRowData(selectRow)
    $('#save-button').submit()
  });
  // 退勤時間変更
  $('.end_work').children('select').on('change', function () {
    selectRow = Number($(this).parent().attr('name').split('_')[2])
    changeWorkStatus(selectRow, $(`#status_${selectRow}`).parent().parent().attr('class').split(' ')[1].split('_')[3])
    changeRowData(selectRow)
    $('#save-button').submit()
  });

  // ステータス変更
  $('.status').children('select').on('change', function () {
    selectRow = Number($(this).parent().attr('name').split('_')[2])
    changeRowData(selectRow)
    if ($(`select[name=status_${selectRow}]`)[0].value.indexOf('vacation') != -1) {
      $('#modalDialog').fadeIn(0);
      $('#modalDialog').draggable();
    } else {
      $('#save-button').submit()
    }
  });

  // statusがvacationになった時理由を入力させるダイアログを表示
  $('#applyButton').on('click', () => {
    $('input[name=vacation_reason]')[0].value = $('#apply_reason')[0].value
    $('#save-button').submit()
  });
  $('#closeButton').on('click', () => {
    $(`#status_${selectRow}`)[0].options[0].selected = true
    $('#modalDialog').fadeOut(0);
  })
  $('#cancelButton').on('click', () => {
    $(`#status_${selectRow}`)[0].options[0].selected = true
    $('#modalDialog').fadeOut(0);
  })
});

function changeWorkStatus(row, youbi){
  $(`#status_${row}`)[0].value = (youbi == 'holiday' || youbi == '0' || youbi == '6' ) ? "holiday_work" : "work"
}

function changeRowData(row) {
  $('input[name=change_day]')[0].value = row
  $('input[name=change_start_hour]')[0].value = $(`#work_${row}_start_4i`)[0].value
  $('input[name=change_start_minute]')[0].value = $(`#work_${row}_start_5i`)[0].value
  $('input[name=change_end_hour]')[0].value = $(`#work_${row}_end_4i`)[0].value
  $('input[name=change_end_minute]')[0].value = $(`#work_${row}_end_5i`)[0].value
  $('input[name=change_status]')[0].value = $(`#status_${row}`)[0].value
}