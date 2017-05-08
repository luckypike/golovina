$(function(){
  $('.color, .size').on('click', function() {
    $('.color, .size').not(this).removeClass('active');
    $(this).toggleClass('active');
  });



  var product_swiper = new Swiper('.swiper_product', {
  });
});
