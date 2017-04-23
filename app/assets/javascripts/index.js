$(function() {
  var swiper = new Swiper('.swiper_primary', {
    initialSlide: 1,
    nextButton: '.swiper-button-next',
    prevButton: '.swiper-button-prev',
    onSlideChangeStart: function(swiper) {
      if(!swiper.isEnd) {
        swiper.nextButton.find('.label').text($(swiper.slides[swiper.activeIndex + 1]).data('label'));
      }

      if(!swiper.isBeginning) {
        swiper.prevButton.find('.label').text($(swiper.slides[swiper.activeIndex - 1]).data('label'));
      }

      //console.log();

      //if(swiper.slides[swiper.activeIndex + 1] != undefined) {
      //
      //}

      //console.log(swiper);
    }
  });
  var swiperV = new Swiper('.swiper_secondary', {
    pagination: '.swiper-pagination',
    direction: 'vertical',
    mousewheelControl: true,
    onSlideChangeStart: function(swiper) {
      swiper.paginationContainer.removeClass('act-0 act-1 act-2 act-3 act-4 act-5 act-6 act-7 act-8 act-10').addClass('act-' + swiper.activeIndex);
    },
    onInit: function(swiper) {
      swiper.paginationContainer.addClass('act-0');
    }
  });
});