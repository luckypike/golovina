$(function(){
  if($('.page_about_slider').length > 0) {
    _as = $('.swiper-container');

    swiper_create(_as);
  }

  var _window = $(window);
  var _pacw = $('.page_about_collection_wrapper');

  if(_pacw.length > 0) {
    _window.on('scroll', function() {
      $('.header').toggleClass('about_act', _pacw.height() - 40 <= _window.scrollTop());
    }).trigger('scroll');
  }

  if($('.lookbook_intro_text').length > 0) {
    var _lit = $('.lookbook_intro_text');

    $('.spoil_btn').click(function(){
      $('.spoil').slideToggle();
      $('.spoil_btn').toggleText('Скрыть', 'Читать далее');
    })
  }

  function swiper_create(swpr_cntnr) {
    _as.append('<div class="swiper-pagination"></div>');

    var swiper = new Swiper (_as, {
      freeMode: false,
      slidesPerView: 'auto',
      centeredSlides: true,
      speed: 600,
      pagination: $('.swiper-pagination', _as),
      paginationType: 'bullets',
      paginationFractionRender: function(swiper, currentClassName, totalClassName) {
        return '<span class="' + currentClassName + '"></span>' +
                '/' +
                '<span class="' + totalClassName + '"></span>';
      },
      paginationClickable: true,
    });

    return swiper;
  }
});

jQuery.fn.extend({
  toggleText: function(stateOne, stateTwo) {
    return this.each(function() {
        stateTwo = stateTwo || '';
        $(this).text() !== stateTwo && stateOne ? $(this).text(stateTwo)
                                                : $(this).text(stateOne);
    });
  }
});