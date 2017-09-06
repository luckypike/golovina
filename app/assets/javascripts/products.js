$(function(){
  var filters = $('.fd').data('cur');

  $('.fd_i').on('click', '.t', function() {
    var _fdi = $(this).parent();
    $('.fd_d').not(_fdi).removeClass('fd_d');
    _fdi.toggleClass('fd_d', !_fdi.is('.fd_d'));
    if(_fdi.is('.fd_d')) {
      $('.page_container').addClass('under_filters');
    } else {
      $('.page_container').removeClass('under_filters');
    }
    // $('.fd_l .f.' + _fdi.data('f')).toggleClass('fa', _fdi.is('.fd_d'));

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
  });

  $('.f_l_i').each(function() {
    var _this = $(this);
    if($.inArray(_this.data('v'), filters[_this.data('f')]) >= 0) {
      _this.addClass('active');
    }
  });

  var _evf = $('.edit_variant');

  _evf.on('change', function() {
    var _this = $(this);

    $('.form_actions input', _this).trigger('click');

    // _evf.trigger('submit.rails');
    // _evf.submit();

    // return false;

  });

  var _v = $('.variants.live');

  if(_v.length) {
    var hash = location.hash;

    _v.each(function() {
      var _vv = $(this);
      var _s = _vv.next();
      var _variants = $('.variants_list_item', _vv);
      var _variant = _variants.first();
      var _pp = _vv.closest('.page_product');

      var _sizes = $('.sizes_list_item', _s);

      if(_pp.length) {
        if(hash == '') {
          if(_variants.length > 1) {
            history.replaceState(undefined, undefined, '#' + _variant.data('id'));
          }
        } else {
          _variants.each(function(i) {
            var _tv = _variants.eq(i);
            if('#' + _tv.data('id') == hash) {
              _variant = _tv;
            }
          });
        }
      }

      _variants.on('click', function() {
        var _this = $(this);
        _variants.not(this).removeClass('active');
        _this.addClass('active');


        var sizes = _s.data('sizes')[_this.data('id')];
        var label = _this.data('label');

        var _vl = _this.parent().prev();
        _vl.text(label);

        if($.inArray(0, sizes) >= 0) {
          _s.addClass('one_size');

          _sizes.each(function() {
            var _cs = $(this);
            if(parseInt(_cs.data('size')) == 0) {
              _cs.removeClass('inactive').addClass('active');
            }
          });

        } else {
          _s.removeClass('one_size');
          _sizes.each(function() {
            var _cs = $(this);

            if(parseInt(_cs.data('size')) == 0) {
              _cs.removeClass('active');
            } else {
              if($.inArray(parseInt(_cs.data('size')), sizes) < 0) {
                _cs.addClass('inactive').removeClass('active');
              } else {
                _cs.removeClass('inactive');
              }
            }
          });
        }




        if(_pp.length & _variants.length > 1) {
          history.replaceState(undefined, undefined, '#' + _this.data('id'));
        }

        var _il = _this.closest('.product').find('.product_images .images_list');
        var _pip = _il.parent();
        _pip.data('loading', true);
        var swiper = _pip.data('swiper');
        if(swiper) {
          swiper.destroy(true, true);
        }


        $.getJSON(_this.data('url'), function(images) {
          _il.html('');
          $.each(images, function(i, image) {
            _il.append('<div class="images_list_item swiper-slide"><div class="image"><img src="' + image.photo.thumb.url + '"></div></div>');
          });

          _pip.append('<div class="swiper-pagination"></div>');

          if(_il.css('display') == 'flex') {
            var swiper = new Swiper (_pip, {
              pagination: $('.swiper-pagination', _pip),
              paginationClickable: true,
              paginationBulletRender: function(swiper, index, className) {
                console.log();
                var url = $(swiper.slides[index]).find('img').attr('src');
                return '<div class="' + className + '"><div class="img" style="background-image: url(' + url + ')"></div></div>';
              },
            });
            _pip.data('has_swiper', true);
            _pip.data('swiper', swiper);
          }

          _pip.data('loading', false);
        });
      });

      _sizes.on('click', function() {
        var _this = $(this);
        if(!_this.is('.inactive')) {
          _this.addClass('active');
          _sizes.not(this).removeClass('active');
        }

      });

      _variant.trigger('click');
    });
  }

  var _pi = $('.product_images');
  var _window = $(window);

  _pi.on('swiper', function() {
    var _this = $(this);
    var _il = $('.images_list', this);

    if(!_this.data('loading')) {
      if(_il.css('display') == 'flex') {
        if(!_this.data('has_swiper')) {
          var swiper = new Swiper (_this, {

          });

          _this.data('swiper'. swiper);

          _this.data('has_swiper', true);
        }
      } else {
        if(_this.data('has_swiper')) {
          var swiper = _this.data('swiper');
          swiper.destroy(true, true);
          _this.data('has_swiper', false);
        }
      }
    }
  });


  _window.on('resize', function() {
    _pi.trigger('swiper');
  }).trigger('resize');





  // var _pd = $('.page_product .product_data');
  // var _window = $(window);

  // if(_pd.length) {
  //   _window.on('scroll', function() {
  //     _pd.trigger('move');
  //   }).trigger('scroll');

  //   _pd.on('move', function() {
  //     var _this = $(this);
  //     _this.css({
  //       top: _window.scrollTop()
  //     });
  //   });
  // }








  // $('.products_list_item').on('click', '.a, .pre .image', function(e) {
  //   var _this = $(this);
  //   var _pi = _this.parent().parent();
  //   var _pi = _this.parent().parent();
  //   var _pi = _this.parent().parent();
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
