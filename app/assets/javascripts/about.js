$(function(){
  if($('.page_about_slider').length > 0) {
    _as = $('.swiper-container');

    swiper_create(_as);
  }

  var _window = $(window);
  var _pacw = $('.page_about_collection_wrapper');

  if(_pacw.length > 0) {
    _window.on('scroll', function() {
      $('.header').toggleClass('about_act', _pacw.height() - 30 <= _window.scrollTop());
    }).trigger('scroll');
  }

  if($('.collection_images').length > 0) {
    _as = $('.swiper-container-image');

    var col_image = new Swiper (_as, {
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

    // swiper_create(_as);
  }

  if($('.collection_thumbs').length > 0) {
    _as = $('.swiper-container-thumbs');

    _as.append('<div class="swiper-pagination"></div>');
    var col_thumbs = new Swiper (_as, {
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

    col_image.params.control = col_thumbs;
    col_thumbs.params.control = col_image;
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