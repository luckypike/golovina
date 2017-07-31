$(function() {


  var _window = $(window);
  var wh = _window.height();
  var whz = wh / 2;
  var _psit = $('.page_static_index_themes');

  if(_psit.length > 0) {
    var _tt = $('.theme .mb', _psit);
    var tt_positions = [];
    _tt.each(function() {
      tt_positions.push($(this).offset().top);
    });


    _window.on('scroll', function() {
      var hr = _window.scrollTop() + _window.height() / 2;
      _tt.each(function(_, el) {
        var _el = $(el);
        var k = 0;
        if(hr + whz < tt_positions[_]) {
          k = -1;
        } else if(hr - whz > tt_positions[_]) {
          k = 1;
        } else {
          k = (hr - tt_positions[_]) / (whz);
          if(k > -0.4) {
            _el.addClass('wbg');
          }
          // console.log((hr - tt_positions[_]) + ' / ' + (_window.height() / 4));
          // console.log((tt_positions[_] - hr - _window.height() / 2) + ' / ' + (_window.height() / 2));
        }


        // if(k > 0) {
        //   // k *= k;
        //   k *= -1;
        // } else {
        //   // k *= k;
        // }

        if(_window.width() >= 960) {
          _el.css({
            transform: 'translateY(' + (_el.parent().height() / 4 * k * -1) + 'px)'
          });
        }
      });
    }).trigger('scroll');
  }


  // var mint = new Vivus('mint_ani', {
  //   type: 'scenario',
  //   onReady: function() {
  //     $('.desc', _fl).removeClass('inact');
  //   }
  // });
});

