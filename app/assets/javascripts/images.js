// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function(){
  $('.product_images').on('click', function() {
    console.log('QQQ');
    $(this).closest('.page_product').toggleClass('full');
  });
});
