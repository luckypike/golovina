$(function(){
  var filters = $('.fd').data('cur');
  var _pheight;

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
    if(_this.data('v') == -1) {
      filters[_this.data('f')] = [];
    } else {
      var p = $.inArray(_this.data('v'), filters[_this.data('f')]);
      if(p >= 0) {
        filters[_this.data('f')].splice(p, 1);
      } else {
        filters[_this.data('f')].push(_this.data('v'));
      }
    }



    window.location.href = $('.fd').data('url') + '?' + $.param(filters);
  });

  $('.f_l_i').each(function() {
    var _this = $(this);
    if($.inArray(_this.data('v'), filters[_this.data('f')]) >= 0) {
      _this.addClass('active');
    }


    if(filters[_this.data('f')].length == 0 && _this.data('v') == -1) {
      _this.addClass('active');
    }
  });

  var _evf = $('.edit_variant');

  _evf.on('change', function() {
    var _this = $(this);
    $('.form_actions input', _this).trigger('click');
  });

  var _v = $('.variants.live');

  if(_v.length) {
    $('.another_variants').on('click', function() {
      $(this).parent().next().slideToggle();
    });

    _v.initProduct();
  }

  var _pi = $('.product_images');
  var _window = $(window);

  // _pi.on('swiper', function() {
  //   var _this = $(this);
  //   var _il = $('.images_list', this);

  //   if(!_this.data('loading')) {
  //     if(_il.css('display') == 'flex') {
  //       if(!_this.data('has_swiper')) {
  //         var swiper = new Swiper (_this, {

  //         });

  //         _this.data('swiper'. swiper);

  //         _this.data('has_swiper', true);
  //       }
  //     } else {
  //       if(_this.data('has_swiper')) {
  //         var swiper = _this.data('swiper');
  //         swiper.destroy(true, true);
  //         _this.data('has_swiper', false);
  //       }
  //     }
  //   }
  // });


  _window.on('resize', function() {
    _pi.trigger('swiper');
  }).trigger('resize');

  $('.delivery_fast .tabs_item').on('click', function() {
    $('.delivery_fast .tabs_item').not(this).removeClass('active');
    $(this).addClass('active');

    $('.delivery_fast .text_item').removeClass('active');
    $('.delivery_fast .text_item.' + $(this).attr('rel')).addClass('active');

    $(this).closest('.acc_item').find('.title_desc').toggleClass('hdd', $(this).attr('rel') != 'nn');
  });



  var i = 0;
  $('.page_kit_products .more').on('click', function(){
    var _ss = $(this).clone(true);
    if(i == $(this).data('similar').length) i = 0;
    $.ajax({
      url: '/catalog/' + $(this).data('id') + '/similar/' + $(this).data('similar')[i],
      context: $(this).closest('.products_item'),
    }).done(function(data){
      $(this).animate({
        opacity: 0
      } , 500, function(){
        $(this).removeClass('variant_out').find('.product').remove();
        $(this).prepend(data);
        _ss.insertAfter($(this).find('.product_data'));
        _vs = $(this).find('.variants.live');
        _vs.initProduct();
        $(this).animate({opacity: 1}, 500);
      });
    });
    i++;
    return false;
  });
});


(function( $ ) {
  $.fn.initProduct = function() {
    var hash = location.hash;

    return this.each(function() {
      var _vv = $(this);
      var _s = _vv.parent().next().next().find('.sizes');
      var _b = _s.next();
      var _oos = _b.next().next();
      var _variants = $('.variants_list_item', _vv);
      var _variant = _variants.first();
      var _pp = _vv.closest('.page_product');
      var _ai = _vv.closest('.product').find('.acc_item');

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
      } else {
        _variants.each(function(i) {
          var _tv = _variants.eq(i);
          if(_tv.data('id') == _vv.data('variant_active')) {
            _variant = _tv;
          }
        });
      }

      // TODO: rewrite this selectors

      _b.on('set_variant', function() {
        $('.after_add', _b.parent()).hide();
        $('.purchase', _b).hide();
        $('.cart', _b).show();
        if(_b.data('wishlist') == undefined) {
          _b.data('wishlist', $('.wishlist', _b).attr('href'));
        }

        $('.wishlist', _b).attr('href', _b.data('wishlist') + '?variant_id=' + _vv.data('active_variant'));
        _b.trigger('set_size');
      });

      _b.on('set_size', function() {
        $('.after_add', _b.parent()).hide();
        $('.purchase', _b).hide();
        $('.cart', _b).show();
        if(_b.data('cart') == undefined) {
          _b.data('cart', $('.cart', _b).attr('href'));
        }

        if(_s.data('active_size') == undefined) {
          $('.cart', _b).attr('href', _b.data('cart')).addClass('inactive');
        } else {
          $('.cart', _b).attr('href', _b.data('cart') + '?variant_id=' + _vv.data('active_variant') + '&size=' + _s.data('active_size')).removeClass('inactive');
        }
      });

      $('.cart', _b).on('click', function() {
        if($(this).is('.inactive')) {
          return false;
        }

        $(this).addClass('inactive');
      }).on('ajax:success', function(event) {
        var detail = event.detail;
        var data = detail[0], status = detail[1],  xhr = detail[2];

        $(this).removeClass('inactive');
        if(parseInt(data) > 0) {
          $(this).hide().next().show();
          $('.header .cart').removeClass('nil').addClass('active').find('.counter .d').html(parseInt(data));
          $('.after_add', _b.parent()).slideDown();
          // _b.text(_b.data('cart_text'));
        } else {
          $('.header .cart').addClass('nil').removeClass('active');
        }
      });


      $('.wishlist', _b).on('ajax:success', function(event) {
        var detail = event.detail;
        var data = detail[0], status = detail[1],  xhr = detail[2];

        if(data == 'true'){
          $(this).addClass('in_wl');
        } else {
          $(this).removeClass('in_wl');
        }
      });

      _variants.on('click', function() {
        var _this = $(this);
        _variants.not(this).removeClass('active');
        _this.addClass('active');
        _vv.data('active_variant', _this.data('id'));


        var sizes = _s.data('sizes')[_this.data('id')];
        var label = _this.data('label');

        var _vl = _this.parent().next();
        _vl.text(label);


        _oos.removeClass('active');

        if($.inArray(0, sizes) >= 0) {
          _s.addClass('one_size');

          _sizes.each(function() {
            var _cs = $(this);
            if(parseInt(_cs.data('size')) == 0) {
              if(_this.data('oos') == true) {
                _cs.removeClass('active').addClass('inactive');
                _s.removeData('active_size');
                _b.trigger('set_size');
                _oos.addClass('active');

              } else {
                _cs.removeClass('inactive').addClass('active');
                _cs.trigger('click');
              }
            }
          });
        } else {
          if(_this.data('oos') == true) {
            sizes = [];
            _oos.addClass('active');

          }

          _s.removeClass('one_size');
          _sizes.each(function() {
            var _cs = $(this);

            if(parseInt(_cs.data('size')) == 0) {
              _cs.removeClass('active');
            } else {
              if($.inArray(parseInt(_cs.data('size')), sizes) < 0) {
                _cs.addClass('inactive').removeClass('active');
                if(_s.data('active_size') != undefined && _s.data('active_size') == _cs.data('size')) {
                  _s.removeData('active_size');
                  _b.trigger('set_size');
                }
              } else {
                _cs.removeClass('inactive');
              }
            }
          });
        }



        if(_pp.length & _variants.length > 1) {
          history.replaceState(undefined, undefined, '#' + _this.data('id'));
        }

        var _ils = _this.closest('.product').find('.images_list');
        var _il = _this.closest('.product').find('.images_list_swiper');
        var _il_l = _this.closest('.product').find('.images_list_swiper_l');

        var _pip = _il.parent();
        _pip.data('loading', true);

        var _pip_l = _il_l.parent();
        _pip_l.data('loading', true);

        var swiper = _pip.data('swiper');
        if(swiper) {
          swiper.destroy(true, true);
        }

        var swiper_l = _pip_l.data('swiper');
        if(swiper_l) {
          swiper_l.destroy(true, true);
        }

        _b.trigger('set_variant');


        $.getJSON(_this.data('url'), function(data) {
          _ils.html('');
          $.each(data.images, function(i, image) {
            _ils.append('<div class="images_list_item swiper-slide"><div class="image"><img src="' + image.photo.thumb.url + '"></div></div>');
          });

          if(data.wishlist) {
            _this.closest('.product').find('.wishlist').addClass('in_wl');
          } else {
            _this.closest('.product').find('.wishlist').removeClass('in_wl');
          }

          _pip.append('<div class="swiper-pagination"></div>');
          _pip_l.append('<div class="swiper-pagination"></div>');

          if(_il.css('display') == 'flex') {
            var swiper = swiper_create(_pip);
          }

          if($('.page_common').hasClass('page_kit')) {
            var swiper_l = swiper_create(_pip_l);
          }

          _pip.data('loading', false);
          _pip_l.data('loading', false);
        }).done(function() {
          $('.page_product .product_data').stick_in_parent();
          _pheight = $('.product_data').outerHeight();
        });
      });

      _sizes.on('click', function() {
        var _this = $(this);
        if(!_this.is('.inactive')) {
          _this.addClass('active');
          _sizes.not(this).removeClass('active');
          _s.data('active_size', _this.data('size'));
          _b.trigger('set_size');
        }

      });

      _variant.trigger('click');

      _ai.find('.title').on('click', function() {
        _ai.find('.content').not($(this).next()).slideUp();
        $(this).next().slideToggle();
        if($('.page_common').hasClass('page_product')) {
          $('.product_data').height(_pheight + 200);
          $(document.body).trigger("sticky_kit:recalc");
        }
      });
    });

    function swiper_create(swpr_cntnr) {
      var swpr = new Swiper (swpr_cntnr, {
        pagination: $('.swiper-pagination', swpr_cntnr),
        paginationType: 'fraction',
        paginationFractionRender: function(swiper, currentClassName, totalClassName) {
          return '<span class="' + currentClassName + '"></span>' +
                  '/' +
                  '<span class="' + totalClassName + '"></span>';
        },
      });
      swpr_cntnr.data('has_swiper', true);
      swpr_cntnr.data('swiper', swpr);

      return swpr;
    }
  };
}( jQuery ));