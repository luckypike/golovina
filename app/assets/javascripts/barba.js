Barba.Pjax.Dom.containerClass = 'barba_container';

Barba.Pjax.originalPreventCheck = Barba.Pjax.preventCheck;

Barba.Pjax.preventCheck = function(evt, element) {
  if (!Barba.Pjax.originalPreventCheck(evt, element)) {
    return false;
  }

  if (element.classList.contains('barba_only')) {
    return true;
  } else {
    return false;
  }
};

// var _h = $('.header');

var Index = Barba.BaseView.extend({
  namespace: 'index',
  onEnter: function() {
    var _window = $(window);
    var _psit = $('.page_static_index_themes');
    var _psis = $('.page_static_index_swiper');
    var _sp = $('.swiper-pagination', _psit);

    $('.header').addClass('index no_hide_logo');

    if(_psit.length > 0) {
      _sp.on('click', '.swiper-pagination-bullet', function() {
        $('html, body').animate({
          scrollTop: _window.height()
        }, 600);
      });

      _window.on('scroll', function() {
        var k = (_window.scrollTop() / _psit.height())  ;
        if(k < 0) k = 0;
        if(k > 1) k = 1;
        var sh = (144 * (k - 1));

        _sp.toggleClass('act', sh > -28);
        $('.header').toggleClass('index_act', sh > -28);

        _sp.css({
          'margin-top': sh + 'px'
        });
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
        autoplay: 4000,
        // paginationBulletRender: function(swiper, index, className) {
        //   return '<div class="' + className + '">' + $(swiper.slides[index + 1]).data('title') + '</div>';
        // },
        autoplayDisableOnInteraction: false,
        onSlideChangeStart: function(swiper) {
          swiper.params.speed = 1400;
          // console.log(swiper.touches);

          var _ss = $('.ss_' + swiper.realIndex);
          $('.ss > div').not(_ss).removeClass('active');
          _ss.addClass('active');
        },
        onTransitionStart: function(swiper) {
          console.log(swiper);
          console.log(swiper.params);
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

      var themes_swiper = new Swiper(_sct, {
        loop: true,
        effect: 'slide',
        pagination: '.swiper-pagination-themes',
        paginationClickable: true,
        paginationBulletRender: function(swiper, index, className) {
          return '<div class="' + className + '"><span class="short">' + $(swiper.slides[index + 1]).data('title-short') + '</span><span class="full">' + $(swiper.slides[index + 1]).data('title') + '</span></div>';
        },
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
      });

      var mint = new Vivus('mint_ani', {
        type: 'scenario',
        onReady: function() {
          $('.text', _psis).removeClass('inact');
        }
      });

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
  },
  onEnterCompleted: function() {
    console.log('onEnterCompleted');
  },
  onLeave: function() {
    $('.header').removeClass('index no_hide_logo');
  },
  onLeaveCompleted: function() {
    console.log('onLeaveCompleted');
  }
});

Index.init();


// Barba.Pjax.getTransition = function() {
//   return ContTransition;
// };

var ContTransition = Barba.BaseTransition.extend({
  start: function() {
    Promise
      .all([this.newContainerLoading, this.fillTop()])
      .then(this.fadeIn.bind(this));
  },

  fillTop: function() {
    // return $(this.oldContainer).find('.page_static_index_swiper').animate({
    //   height: 120
    // }, 800, function() {
    //   $(window).scrollTop(0);
    // }).promise();

    //
    // console.log($(this.oldContainer));

    $('html, body').animate({
      scrollTop: 0
    }, 600);

    // $('html, body').animate({
    //   scrollTop: $(this.oldContainer).find('.page_static_index_themes').position().top
    // }, 200, function() {
    //   // console.log('QQ');
    //   // $(this.oldContainer).hide();
    //   // $(window).scrollTop(0);
    //   // $(this.newContainer).show();

    //   _this.done();
    // });
  },

  fadeIn: function() {
    var _this = this;
    _this.done();
  }
});


$(function() {
  var _bc = $('.' + Barba.Pjax.Dom.containerClass);

  if(_bc.length > 0) {
    Barba.Pjax.init();
  }
});