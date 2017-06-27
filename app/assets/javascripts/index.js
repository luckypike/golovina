$(function() {
  // console.log($('.page_static_index_themes').position().top);
  var _f = $('.fade');
  var _fl = $('.fade .logo_w');
  var _fo = $('.fade_out');
  var _fi = $('.fade_in');
  var _psip = $('.page_static_index_placeholder');
  var _psit = $('.page_static_index_themes');
  var _ti = $('.themes_list_item_wrp .image .im');

  $(window).on('scroll', function() {
    var scroll_top = $(window).scrollTop();
    var pk = 0;

    if(scroll_top + $(window).height() > _psit.position().top) {
      _psip.addClass('ZZ');
    } else {
      _psip.removeClass('ZZ');
    }

    if(scroll_top + $(window).height() > _psit.position().top) {
      _psip.addClass('QQ');

      _fo.css({
        opacity: 0
      });

      _fi.css({
        opacity: 1
      });

      var pk = 1 - ((scroll_top + $(window).height() - _psit.position().top) / _psit.outerHeight());

    } else {
      var k = scroll_top / (_psip.outerHeight() - _f.outerHeight());

      pk = 0;

      k *= 2;

      if(k < 0) k = 0;
      if(k > 1) k = 1;

      // k *= 0.5;

      _fo.css({
        opacity: 1 - k,
        transform: 'scale(' + (1 + (0.5 * k)) + ')'
      });

      _fi.css({
        opacity: k,
        transform: 'scale(' + (1 + (0.5 * k)) + ')'
        // transform: scale(1 + (0.5 * k))
      });

      _fl.css({
        transform: 'scale(' + (1 + (1.4 * k)) + ')',
        filter: 'blur(' + (30 * k) + 'px)'
      });



      _psip.removeClass('QQ');
    }

    _ti.each(function(i, el) {
      var _this = $(this);

      var sh = _this.data('sp') * pk * 1;
      _this.css({
        transform: "translate3d(0, " + sh + "px, 0)"
      })
    });
  });



  var index_swiper = new Swiper ('.themes_list', {
    loop: true,
    slidesPerView: 2,
    slidesPerGroup: 2,
    breakpoints: {
      959: {
        slidesPerView: 1,
        slidesPerGroup: 1,
      }
    },
    onInit: function(swiper) {
      $(window).trigger('scroll');
    }
  });

  var mint = new Vivus('mint_ani', {
    type: 'scenario',
    onReady: function() {
      $('.desc', _fl).removeClass('inact');
    }
  });
});

