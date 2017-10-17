// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
  $('.city_toggle .lv4').on('click', function() {
    $('.city_toggle .content').not($(this).next()).slideUp();
    $(this).next().slideToggle();
  });
});