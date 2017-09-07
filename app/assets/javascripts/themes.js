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
});