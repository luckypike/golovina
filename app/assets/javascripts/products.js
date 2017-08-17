$(function(){
  var filters = $('.fd').data('cur');

  $('.color, .size').on('click', function() {
    $('.color, .size').not(this).removeClass('active');
    $(this).toggleClass('active');
  });

  $('.fd_i').on('click', '.t', function() {
    var _fdi = $(this).parent();
    $('.fd_d').not(_fdi).removeClass('fd_d');
    _fdi.toggleClass('fd_d', !_fdi.is('.fd_d'));
    $('.fd_l .f.' + _fdi.data('f')).toggleClass('fa', _fdi.is('.fd_d'));

  });

  $('.fd_w').on('mouseleave', function() {
    var _fdi = $('.fd_i.fd_d', this);
    $('.t', _fdi).trigger('click');
  });

  $('.f_l_i').on('click', function() {
    var _this = $(this);
    var p = $.inArray(_this.data('v'), filters[_this.data('f')]);
    if(p >= 0) {
      filters[_this.data('f')].splice(p, 1);
    } else {
      filters[_this.data('f')].push(_this.data('v'));
    }

    window.location.href = $('.fd').data('url') + '?' + $.param(filters);
    ;
  });

  $('.f_l_i').each(function() {
    var _this = $(this);
    if($.inArray(_this.data('v'), filters[_this.data('f')]) >= 0) {
      _this.addClass('active');
    }
  });


  // $('.products_list_item').on('click', '.a, .pre .image', function(e) {
  //   var _this = $(this);
  //   var _pi = _this.parent().parent();
  //   // if(_this.is('.a')) _pi = _this.parent();

  //   var source = $("#products-pre-template").html();
  //   var template = Handlebars.compile(source);

  //   if(_pi.is('.o')) {
  //     _pi.removeClass('o').next().removeClass('ao');
  //   } else {
  //     _pi.addClass('o');
  //     var _n = _pi.next();
  //     if(_n.length > 0) {
  //       _n.addClass('ao');
  //     }

  //     $.getJSON(_pi.data('src'), function(product) {
  //       $('.pre', _pi).html(template(product));
  //     });
  //   }

  //   return false;
  // });
});
