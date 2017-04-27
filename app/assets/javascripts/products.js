$(function(){
  $('.color, .size').on('click', function() {
    $('.color, .size').not(this).removeClass('active');
    $(this).toggleClass('active');
  });
});
