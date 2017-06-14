$(function() {
  $('.header_burger, .header_full').on('click', function() {
    $('.header').toggleClass('with_nav');
    $('body').toggleClass('full_screen');
  });

  $('.header_menu_item.hhe')
    .on('mouseenter',
      function(){
        $('.header').addClass('second_row');
      });
  $('.header')
    .on('mouseleave',
      function(){
        $('.header').removeClass('second_row');
      });
});