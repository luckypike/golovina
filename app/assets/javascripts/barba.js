// Barba.Pjax.Dom.containerClass = 'barba_container';

// Barba.Pjax.originalPreventCheck = Barba.Pjax.preventCheck;

// Barba.Pjax.preventCheck = function(evt, element) {
//   if (!Barba.Pjax.originalPreventCheck(evt, element)) {
//     return false;
//   }

//   if (element.classList.contains('barba_only')) {
//     return true;
//   } else {
//     return false;
//   }
// };

// // var _h = $('.header');

// var Index = Barba.BaseView.extend({
//   namespace: 'index',
//   onEnter: function() {

//   },
//   onEnterCompleted: function() {
//     console.log('onEnterCompleted');
//   },
//   onLeave: function() {
//     $('.header').removeClass('index no_hide_logo');
//   },
//   onLeaveCompleted: function() {
//     console.log('onLeaveCompleted');
//   }
// });

// Index.init();


// // Barba.Pjax.getTransition = function() {
// //   return ContTransition;
// // };

// var ContTransition = Barba.BaseTransition.extend({
//   start: function() {
//     Promise
//       .all([this.newContainerLoading, this.fillTop()])
//       .then(this.fadeIn.bind(this));
//   },

//   fillTop: function() {
//     // return $(this.oldContainer).find('.page_static_index_swiper').animate({
//     //   height: 120
//     // }, 800, function() {
//     //   $(window).scrollTop(0);
//     // }).promise();

//     //
//     // console.log($(this.oldContainer));

//     $('html, body').animate({
//       scrollTop: 0
//     }, 600);

//     // $('html, body').animate({
//     //   scrollTop: $(this.oldContainer).find('.page_static_index_themes').position().top
//     // }, 200, function() {
//     //   // console.log('QQ');
//     //   // $(this.oldContainer).hide();
//     //   // $(window).scrollTop(0);
//     //   // $(this.newContainer).show();

//     //   _this.done();
//     // });
//   },

//   fadeIn: function() {
//     var _this = this;
//     _this.done();
//   }
// });


// $(function() {
//   var _bc = $('.' + Barba.Pjax.Dom.containerClass);

//   if(_bc.length > 0) {
//     Barba.Pjax.init();
//   }
// });