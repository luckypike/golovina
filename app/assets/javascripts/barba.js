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


// var Homepage = Barba.BaseView.extend({
//   namespace: 'index',
//   onEnter: function() {
//     console.log('onEnter');
//   },
//   onEnterCompleted: function() {
//     console.log('onEnterCompleted');
//   },
//   onLeave: function() {
//     console.log('onLeave');
//   },
//   onLeaveCompleted: function() {
//     console.log('onLeaveCompleted');
//   }
// });

// Homepage.init();


Barba.Pjax.getTransition = function() {
  return ContTransition;
};

var ContTransition = Barba.BaseTransition.extend({
  start: function() {
    Promise
      .all([this.newContainerLoading, this.fillTop()])
      .then(this.fadeIn.bind(this));
  },

  fillTop: function() {
    return $(this.oldContainer).find('.page_static_index_swiper').animate({
      height: 0
    }, 800).promise();

    // $(window).scrollTop(0);
    // console.log($(this.oldContainer));


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
  }
});


$(function() {
  var _bc = $('.' + Barba.Pjax.Dom.containerClass);

  if(_bc.length > 0) {
    Barba.Pjax.init();
  }
});