$(function() {
  $('.header_burger').on('click', function() {
    $('.header').toggleClass('with_nav');
    // $('body').toggleClass('full_screen');
  });

  $('.header_menu_item .title a').on('click', function(e) {
    var _hmi = $(this).closest('.header_menu_item');
    if(_hmi.is('.active')) {
      _hmi.removeClass('active');
      $('.sub', _hmi).slideUp();
    } else {
      $('.header_menu_item.active .sub').slideUp();
      $('.header_menu_item.active').removeClass('active');
      _hmi.addClass('active');
      $('.sub', _hmi).slideDown();
    }
    e.preventDefault();
  });

  $('.header_menu_item.active').each(function(){
    $('.sub', this).show();
  });

});