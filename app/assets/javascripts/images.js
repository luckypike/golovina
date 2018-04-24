// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function(){
  $('.product_images .images_list').on('click', function() {
    $(this).closest('.page_product').toggleClass('full');
  });
});
