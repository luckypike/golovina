$(function(){
  $('.color, .size').on('click', function() {
    $('.color, .size').not(this).removeClass('active');
    $(this).toggleClass('active');
  });

  $('.fd').on('mouseenter', function(){
    $(this).addClass('fd_d');
  }).on('mouseleave', function() {
    $(this).removeClass('fd_d');
  });



  // var product_swiper = new Swiper('.swiper_product', {
  // });
});
