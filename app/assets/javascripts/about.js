$(function(){
  if($('.page_about_slider').length > 0) {
    _as = $('.swiper-container');

    swiper_create(_as);
  }

  if($('.collection_slider').length > 0) {
    _as = $('.swiper-container');

    swiper_create(_as);
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