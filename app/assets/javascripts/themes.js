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

  $('.theme_intro_wrapper').on('click', function(e){
    if(!$(e.target).hasClass('edit')) {
      var _this = $(this);
      var _tkw = $(this).next();
      var _tk = _tkw.find('.theme_kits');


      if(_tkw.is(':visible')) {
        _tkw.slideUp(400, function() {
          var swiper = _tk.data('swiper');

          if(swiper) {
            swiper.destroy(true, true);
          }
        });

      } else {
        $("html, body").stop().animate({ scrollTop: (_this.offset().top + _this.height() / 2) }, 500, 'swing');

        _tkw.slideToggle(400, function() {
          if($(window).width() < 1280) {
            var swiper = new Swiper (_tk, {
              freeMode: false,
              slidesPerView: 'auto',
            });
            _tk.data('swiper', swiper);
          }
        });
      }
    }
  });
});