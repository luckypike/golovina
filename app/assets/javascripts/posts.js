$(function() {
  var _pc = $('.post_collection');
  console.log(_pc);
  if($(window).width() < 960) {
    var swiper = new Swiper (_pc, {
      freeMode: false,
      slidesPerView: 'auto',
    });
    _pc.data('swiper', swiper);
  }
});
