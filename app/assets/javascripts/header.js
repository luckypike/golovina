$(function() {
  var _h = $('.header');
  $('.header_burger').on('click', function() {
    if(_h.is('.active')) {
      _h.removeClass('active');
      if($('.header_menu', _h).css('visibility') == 'visible') {
      } else {
        _h.addClass('with_nav');
      }
    } else {
      _h.toggleClass('with_nav');
    }
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


  $('.phone').on('click', function(){
    _h.toggleClass('call_me');
  });

  $('.header_contact .close').on('click', function() {
    _h.removeClass('call_me');
  });

});