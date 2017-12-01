$(function() {
  var _window = $(window);
  var _ptt = $('.page_theme_themes');

  if(_ptt.length) {
    _window.on('scroll', function() {
      if(_window.scrollTop() + _window.height() * 2 / 3 > _ptt.offset().top) {
        $('.theme_intro', _ptt).addClass('vis');
      }
    }).trigger('scroll');
  }

  if($('.page_themes_themes').length > 0) {
    $('.theme_intro_wrapper').each(function(e) {
      var _this = $(this);
      var _tkw = $(this).next();
      var _tk = _tkw.find('.theme_kits');

      if($(window).width() < 1280) {
        var swiper = new Swiper (_tk, {
          freeMode: false,
          slidesPerView: 'auto',
        });
        _tk.data('swiper', swiper);
      }
    });
  }
});