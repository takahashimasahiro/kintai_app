// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
import '../src/stylesheets/application.scss';
import '../src/stylesheets/attendances.scss';
import $ from 'jquery';

const today = new Date();
const thisHour = () => { return (`00${today.getHours()}`).slice(-2) }
const getMinutes = () => { return (`00${today.getMinutes()}`).slice(-2) }

$(function () {
  $('button[name=syukkin]').on('click', () => {
    $(`#work_${today.getDate()}_start_4i`)[0].value = thisHour()
    $(`#work_${today.getDate()}_start_5i`)[0].value = getMinutes()
    changeRowData(today.getDate())
  });
  $('button[name=taikin]').on('click', () => {
    $(`#work_${today.getDate()}_end_4i`)[0].value = thisHour()
    $(`#work_${today.getDate()}_end_5i`)[0].value = getMinutes()
    changeRowData(today.getDate())
  });
  $('th').children('select').on('change', function () {
    changeRowData(Number($(this).parent().attr('name').split('_')[2]))
    $('#save-button').submit()
  });
  // TODO :休暇申請の通った日付は状態が変更できないようにする。
});

function changeRowData(row) {
  $('input[name=change_day]')[0].value = row
  $('input[name=change_start_hour]')[0].value = $(`#work_${row}_start_4i`)[0].value
  $('input[name=change_start_minute]')[0].value = $(`#work_${row}_start_5i`)[0].value
  $('input[name=change_end_hour]')[0].value = $(`#work_${row}_end_4i`)[0].value
  $('input[name=change_end_mitute]')[0].value = $(`#work_${row}_end_5i`)[0].value
  $('input[name=change_status]')[0].value = $(`#status_${row}`)[0].value
}