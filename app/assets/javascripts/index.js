$(function() {

  var _window = $(window);
  // var wh = _window.height();
  // var whz = wh / 2;
  var _psit = $('.page_static_index_themes');
  var _psis = $('.page_static_index_swiper');
  var _sp = $('.swiper-pagination', _psit);

  if(_psit.length > 0) {
    _sp.on('click', '.swiper-pagination-bullet', function() {
      $('html, body').animate({
        scrollTop: _window.height()
      }, 600, function(){

        // Add hash (#) to URL when done scrolling (default click behavior)
        // window.location.hash = hash;
      });
    });
  //   var _tt = $('.theme .mb', _psit);
  //   var tt_positions = [];
  //   _tt.each(function() {
  //     tt_positions.push($(this).offset().top);
  //   });


    _window.on('scroll', function() {
      var k = (_window.scrollTop() / _psit.height())  ;
      if(k < 0) k = 0;
      if(k > 1) k = 1;
      var sh = (144 * (k - 1));

      _sp.toggleClass('act', sh > -28);

      _sp.css({
        'margin-top': sh + 'px'
      });
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
    }).trigger('scroll');
  }



  // var _psit = $('.page_static_index_themes');
  var _sc = $('.swiper-container', _psis);
  var _sct = $('.swiper-container', _psit);

  if(_psis.length > 0) {
    var index_swiper = new Swiper(_sc, {
      loop: true,
      effect: 'slide',
      // autoplay: 2000,
      // speed: 1200,
      // followFinger: false,

      pagination: '.swiper-pagination-index',
      paginationClickable: true,
      // paginationType: 'custom',
      paginationBulletRender: function(swiper, index, className) {
        return '<div class="' + className + '"><span class="short">' + $(swiper.slides[index + 1]).data('title-short') + '</span><span class="full">' + $(swiper.slides[index + 1]).data('title') + '</span></div>';
      },
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

    var themes_swiper = new Swiper(_sct, {
      loop: true,
      effect: 'slide',
      pagination: '.swiper-pagination-themes',
      paginationClickable: true,
      // paginationType: 'custom',
      paginationBulletRender: function(swiper, index, className) {
        return '<div class="' + className + '"><span class="short">' + $(swiper.slides[index + 1]).data('title-short') + '</span><span class="full">' + $(swiper.slides[index + 1]).data('title') + '</span></div>';
      }

      // autoplay: 2000,
      // speed: 1200,
      // followFinger: false,
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

    _sct.on('recalc', function() {
      _sct.height(_window.height());
    });

    _window.on('resize', function() {
      // _sc.trigger('recalc');
      // _sct.trigger('recalc');
    }).trigger('resize');
  }

});

