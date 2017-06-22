$(function() {
  // console.log($('.page_static_index_themes').position().top);
  var _f = $('.fade');
  var _fl = $('.fade .logo svg');
  var _fo = $('.fade_out');
  var _fi = $('.fade_in');
  var _psip = $('.page_static_index_placeholder');
  var _psit = $('.page_static_index_themes');

  $(window).on('scroll', function() {
    var scroll_top = $(window).scrollTop();

    if(scroll_top + $(window).height() > _psit.position().top) {
      _psip.addClass('ZZ');
    } else {
      _psip.removeClass('ZZ');
    }

    if(scroll_top + $(window).height() > _psit.position().top) {
      _psip.addClass('QQ');

      _fo.css({
        opacity: 0
      });

      _fi.css({
        opacity: 1
      });



    } else {
      var k = scroll_top / (_psip.height() - _f.height());

      k *= 2;

      if(k < 0) k = 0;
      if(k > 1) k = 1;

      // k *= 0.5;

      _fo.css({
        opacity: 1 - k,
        transform: 'scale(' + (1 + (0.5 * k)) + ')'
      });

      _fi.css({
        opacity: k,
        transform: 'scale(' + (1 + (0.5 * k)) + ')'
        // transform: scale(1 + (0.5 * k))
      });

      _fl.css({
        transform: 'scale(' + (1 + (1.4 * k)) + ')'
      });



      _psip.removeClass('QQ');
    }
  });

  $(window).trigger('scroll');
});

