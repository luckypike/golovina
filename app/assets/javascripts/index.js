$(function() {
  var _window = $(window);
  var _psit = $('.page_static_index_themes');
  var _psis = $('.page_static_index_swiper');
  var _sp = $('.swiper-pagination', _psit);

  if(_psit.length > 0) {
    _window.on('scroll', function() {
      $('.header').toggleClass('index_act', _psis.height() - 30 <= _window.scrollTop());
    }).trigger('scroll');
  }

  var _sc = $('.swiper-container', _psis);
  var _sct = $('.swiper-container', _psit);

  if(_psis.length > 0) {
    var index_swiper = new Swiper(_sc, {
      loop: true,
      speed: 1400,
      effect: 'slide',
      pagination: '.swiper-pagination-index',
      paginationClickable: true,
      autoplay: 5000,
      // paginationBulletRender: function(swiper, index, className) {
      //   return '<div class="' + className + '">' + $(swiper.slides[index + 1]).data('title') + '</div>';
      // },
      autoplayDisableOnInteraction: false,
      onSlideChangeStart: function(swiper) {
        swiper.params.speed = 1400;

        var _ss = $('.ss_' + swiper.realIndex);
        if($(swiper.slides[swiper.activeIndex]).data('logo') == 2) {
          $('.header').removeClass('index');
          _psis.addClass('gol_f');
        } else {
          $('.header').addClass('index');
          _psis.removeClass('gol_f');
        }

        $('.ss > div').not(_ss).removeClass('active');
        _ss.addClass('active');
      },

      onTransitionStart: function(swiper) {
        // console.log(swiper);
        // console.log(swiper.params);
      },

      onAutoplayStart: function(swiper) {
        // swiper.params.speed = 2000;
      },

      onAutoplayStop: function(swiper) {
        // swiper.params.speed = 300;
        // console.log('QQQ');
      },

      onSetTransition: function(swiper, transition) {
        // console.log(swiper);
        // console.log(transition);
        // transition = 1500;
      },
      onTouchEnd: function(swiper, event) {
        // console.log('onTouchEnd');
        swiper.params.speed = 300;
      },
    });

    // var mint = new Vivus('mint_ani', {
    //   type: 'scenario',
    //   onReady: function() {
    //     $('.text', _psis).removeClass('inact');
    //   }
    // });

    setTimeout(function() {  $('.text', _psis).removeClass('inact');}, 1100);

    _sc.on('recalc', function() {
      _sc.height(_window.outerHeight());
    });

    _sct.on('recalc', function() {
      _sct.height(_window.outerHeight() - $('.header').outerHeight(true));
    });

    _window.on('resize', function() {
      // _sc.trigger('recalc');
      _sct.trigger('recalc');
    }).trigger('resize');
  }
});
