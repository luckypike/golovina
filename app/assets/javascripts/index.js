$(function() {

  //
  // var wh = _window.height();
  // var whz = wh / 2;
  // var _psit = $('.page_static_index_themes');

  // if(_psit.length > 0) {
  //   var _tt = $('.theme .mb', _psit);
  //   var tt_positions = [];
  //   _tt.each(function() {
  //     tt_positions.push($(this).offset().top);
  //   });


  //   _window.on('scroll', function() {
  //     var hr = _window.scrollTop() + _window.height() / 2;
  //     _tt.each(function(_, el) {
  //       var _el = $(el);
  //       var k = 0;
  //       if(hr + whz < tt_positions[_]) {
  //         k = -1;
  //       } else if(hr - whz > tt_positions[_]) {
  //         k = 1;
  //       } else {
  //         k = (hr - tt_positions[_]) / (whz);
  //         if(k > -0.4) {
  //           _el.addClass('wbg');
  //         }
  //       }

  //       if(_window.width() >= 960) {
  //         _el.css({
  //           transform: 'translateY(' + (_el.parent().height() / 4 * k * -1) + 'px)'
  //         });
  //       }
  //     });
  //   }).trigger('scroll');
  // }

  var _window = $(window);
  var _psis = $('.page_static_index_swiper');
  var _sc = $('.swiper-container', _psis);

  if(_psis.length > 0) {
    var index_swiper = new Swiper(_sc, {
      loop: true,
      effect: 'slide',
      // autoplay: 2000,
      // speed: 1200,
      // followFinger: false,
      autoplayDisableOnInteraction: false,
      onSlideChangeStart: function(swiper) {
        var _ss = $('.ss_' + swiper.realIndex);
        $('.ss > div').not(_ss).removeClass('active');
        _ss.addClass('active');
        // $('.ss_' + swiper.previousIndex).removeClass('active');
      },
      onSetTranslate: function(swiper, translate) {
        // console.log(swiper);
        // console.log(translate);
      },
      onSliderMove: function(swiper, event) {
        var tr = -swiper.translate - swiper.activeIndex * swiper.width;
        // console.log(tr);
        // if(tr > 0) {
        //   console.log(swiper.slides);
        // }
      },
    });

    var mint = new Vivus('mint_ani', {
      type: 'scenario',
      onReady: function() {
        $('.text', _psis).removeClass('inact');
      }
    });

    _sc.on('recalc', function() {
      _sc.height(_window.height());
    });

    _window.on('resize', function() {
      _sc.trigger('recalc');
    }).trigger('resize');
  }


});

