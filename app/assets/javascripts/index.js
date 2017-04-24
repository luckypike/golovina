$(function() {
  var swiper = new Swiper('.swiper_primary', {
    initialSlide: 0,
    nextButton: '.swiper-button-next',
    prevButton: '.swiper-button-prev',
    onSlideChangeStart: function(swiper) {
      if(!swiper.isEnd) {
        swiper.nextButton.find('.label').text($(swiper.slides[swiper.activeIndex + 1]).data('label'));
      }

      if(!swiper.isBeginning) {
        swiper.prevButton.find('.label').text($(swiper.slides[swiper.activeIndex - 1]).data('label'));
      }
    }
  });

  var swipers = new Swiper('.swiper_secondary', {
    pagination: '.swiper-pagination',
    direction: 'vertical',
    //speed: 700,
    //mousewheelControl: true,
    onSlideChangeStart: function(swiper) {
      swiper.paginationContainer.removeClass('act-0 act-1 act-2 act-3 act-4 act-5 act-6 act-7 act-8 act-10').addClass('act-' + swiper.activeIndex);
    },
    onInit: function(swiper) {
      swiper.paginationContainer.addClass('act-0');
    }
  });

  $('.swiper_primary_fast_item').each(function() {
    var _this = $(this);

    _this.load(_this.data('rel') + ' .page');
  });

  $('.swiper_secondary .swiper-pagination').on('click', '.swiper-pagination-bullet-active', function() {
    var _this = $(this);

    $('.swiper_primary_fast_item.active').removeClass('active');
    $('.swiper_primary_fast_item.' + _this.parent().data('rel')).addClass('active');

    $('.swiper_primary_fast').addClass('active');
    $('.header').removeClass('index');
  });



  var indicator = new WheelIndicator({
    elem: document.querySelector('.swiper_primary'),
    callback: function(e){
      var s = $(e.target).closest('.swiper_secondary').data('id');

      if(e.direction == 'up') {
        swipers[s].slidePrev();
      } else {
        swipers[s].slideNext();
      }
      //console.log();
    }
  });

});

