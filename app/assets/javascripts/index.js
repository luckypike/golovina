$(function() {
  var swiper = new Swiper('.swiper_primary', {
    initialSlide: 1
    //pagination: '.swiper-pagination-h',
    //paginationClickable: true,
    //spaceBetween: 50
  });
  var swiperV = new Swiper('.swiper_secondary', {
  //  pagination: '.swiper-pagination-v',
  //  paginationClickable: true,
    direction: 'vertical'
  //  spaceBetween: 50
  });
});