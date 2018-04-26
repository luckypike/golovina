$(function() {
  if(window.location.hash.length > 0 && window.location.hash.substring(1) == 'kit') {
    $("html, body").stop().animate({ scrollTop: $('.kits_list').offset().top - 50}, 500, 'swing');
  }

  $('.kit .product .product_images .images_list').on('click', function() {
    var _this = $(this);
    var swiper = _this.parent().data('swiper');
    swiper.slideNext();
  });

  $('.kits_list_item').on('click', function(e){
    if(!$(e.target).hasClass('edit') && !$(e.target).hasClass('buy_kit')) {
      var _this = $(this);
      var _kpw = $(this).next();
      var _kp = _kpw.find('.kit_products');

      if(_kpw.is(':visible')) {
        _this.removeClass('active');
        _kpw.slideUp(400, function() {
          var swiper = _kp.data('swiper');

          if(swiper) {
            swiper.destroy(true, true);
          }
        });

      } else {
        $("html, body").stop().animate({ scrollTop: (_this.offset().top + _this.height() / 2) }, 500, 'swing');

        _this.addClass('active');
        _kpw.slideToggle(400, function() {
          if($(window).width() < 960) {
            var swiper = new Swiper (_kp, {
              freeMode: false,
              slidesPerView: 'auto',
            });
            _kp.data('swiper', swiper);
          }
        });
      }
    }
    // $('.kit_products_list', _kp);
  });

  // var swiper = new Swiper ('.kit_products', {
  // });


  $('.as_variants_choose_list').on('click', '.as_variants_choose_list_item', function() {
    var _this = $(this);
    _this.toggleClass('selected');

    if(_this.is('.selected')) {
      $(".as_variants").append('<option selected="selected" value="' + _this.data('id') + '"></option>');
    } else {
      $('.as_variants option[value="' + _this.data('id') + '"]').remove();
    }
  });

  $('.as_variants_choose').on('redraw', function() {
    var _this = $(this);
    var _text = $('.as_variants_choose_text input', this);
    var _list = $('.as_variants_choose_list', this);
    var query = _text.val();


    if(_this.data('query') != query) {
      $.getJSON(_this.data('url'), {
          q: query,
          kit_id: _this.data('kit_id'),
          selected: $(".as_variants option:selected").map(function(){ return this.value }).get(),
        })
        .done(function(data) {
          _list.html('');

          $.each(data.selected, function(i, variant) {
            var img = '';
            if(variant.image != undefined) {
              img = '<img src="' + variant.image + '" alt="">';
            }
            var item =  '<div class="as_variants_choose_list_item selected" data-id="' + variant.id + '"><div class="frame">' +
              '<div class="img">' + img + '</div>' +
              '<div class="data">' +
                '<div class="product_label">' + variant.title + '</div>' +
                '<div class="color">' + variant.color + '</div>' +
              '</div>' +
            '</div></div>';
            _list.append(item);
          });

          $.each(data.variants, function(i, variant) {
            var img = '';
            if(variant.image != undefined) {
              img = '<img src="' + variant.image + '" alt="">';
            }
            var item =  '<div class="as_variants_choose_list_item" data-id="' + variant.id + '"><div class="frame">' +
              '<div class="img">' + img + '</div>' +
              '<div class="data">' +
                '<div class="product_label">' + variant.title + '</div>' +
                '<div class="color">' + variant.color + '</div>' +
              '</div>' +
            '</div></div>';
            _list.append(item);
          });

        })
        .fail(function() {

      });
      _this.data('query', query);
    }
  }).trigger('redraw');

  var kwspr = $('.images_m .swiper-container');

  if(kwspr.length > 0) {
    kwspr.append('<div class="swiper-pagination"></div>');

    var kswpr = new Swiper (kwspr, {
      pagination: $('.swiper-pagination'),
      paginationType: 'bullets',
      loop: true,
      autoplay: 4000,
      speed: 500,
    });

    return kwspr;
  }

  $('.as_variants_choose_text input').on('keyup', function() {
    $(this).closest('.as_variants_choose').trigger('redraw');
  });

  $('.dz_preview').on('ajax:success', '.destroy', function(event) {
    var detail = event.detail;
    var data = detail[0], status = detail[1],  xhr = detail[2];

    if(xhr.status == 200) {
      var id = $(this).closest('.dz_preview_item').data('id');

      var _images = $(this).closest('.dz_frm').find('.dz_images');

      var images = $.grep(JSON.parse(_images.val()), function(n, i) {
          return n == id;
      }, true);
      _images.val(JSON.stringify(images));

      $(this).closest('.dz_preview_item').remove();
    }
  });


  $('.dz_form').each(function() {
    var _this = $(this);
    var _images = _this.find('.dz_images');
    var dz = new Dropzone(_this.get(0), {
      url: _this.data('url'),
      dragenter: function () {},
      dragleave: function () {},
      /* setup the new behavior */
      init: function () { setupDragon(this) },

      paramName: 'image[photo]',
      params: _this.data('params'),
      previewsContainer: '.dz_preview',
      previewTemplate: '<div class="dz_preview_item"></div>',
      clickable: '.dz_clickable',
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
    });

    dz.on('success', function(file, data) {
      var images = JSON.parse(_images.val());
      images.push(data.image.id);
      _images.val(JSON.stringify(images));

      $(file.previewElement).data('id', data.image.id)
      $(file.previewElement).append('<div class="pos" data-pos="' + data.image.weight + '"><input type="hidden" name="kit[images_attributes][' + data.image.id + '][weight]" value="0" class="pos_value"><input type="hidden" name="kit[images_attributes][' + data.image.id + '][id]" value="' + data.image.id + '"><div class="l"></div></div><img src="' + data.image.photo.preview.url + '"><div class="control"><a rel="nofollow" data-remote="true" data-method="delete" href="' + data.url + '" class="destroy"></a></div>');
    });
  });

  var _dzp = $('.dz_preview_kit, .form_inputs_variants');

  _dzp.on('click', '.dz_preview_item', function(event) {
    var _this = $(this);
    var _pos = $('.pos', this);
    var _pv = _this.closest('.dz_preview');
    var _t = $(event.target);

    var pos = parseInt(_pos.data('pos'));
    
    if(!isNaN(pos)) {
      if(pos > 0) {
        console.log('>')
         $('.pos', _pv).each(function(i, el) {
          var _el = $(el);
          var cpos = _el.data('pos');
          if(cpos > pos) {
            _el.data('pos', cpos - 1);
          }
        });

        _pv.data('max', _pv.data('max') - 1);

        pos = 0;
      } else if(!_t.is('a.destroy')) {
        pos = _pv.data('max');
        pos = pos + 1;
        _pv.data('max', pos);
      }

      _pos.data('pos', pos);

      _dzp.trigger('redraw');
    }
  });

  _dzp.on('redraw', function() {
    $('.dz_preview_item', _dzp).each(function(i, el) {
      var _el = $(el);
      var _pos = $('.pos', el);
      var pos = _pos.data('pos');

      $('.pos_value', _el).val(pos);


      if(pos < 1) {
        $('.l', _pos).html('');
      } else {
        $('.l', _pos).html(_pos.data('pos'));
      }

    });
  });

  sim = '';
  i = 0;
  $('.kit_products_list_item .more').on('click', function(){
    var self = $(this);
    if(sim.length == 0) {
      $.getJSON('/catalog/' + self.data('id') + '/info')
      .done(function(data) {
        sim = data;
        similar_product(self, i , sim);
      });
    }
    else {
      i++;
      if(i > Object.keys(sim).length - 1) i = 0;
      similar_product(self, i, sim);
    }
    return false;
  });

  function similar_product(self, i, sim) {
    parent = self.closest('.kit_products_list_item');

    parent.fadeOut('fast', function(){
      self.text('Еще');

      parent.find('.fake').attr('href', sim[i]['link']);
      parent.find('.product_title').text(sim[i]['title']);
      parent.find('.image img').attr('src', sim[i]['thumb']);
      parent.find('.out').remove();
      parent.fadeIn('fast');
    });
  }

  // if(_dzp.length == 1) {
  //   var drake = dragula({
  //     containers: [_dzp[0]],
  //     moves: function (el, container, handle) {
  //       return handle.classList.contains('move');
  //     },
  //     // direction: 'vertical',
  //     direction: 'horizontal',
  //     copy: false,
  //   }).on('drag', function(el, source) {
  //     // console.log('QQ');
  //   });
  //   _dzp.on('touchmove', '.move', function(e) {
  //     var _el = $(e.target);
  //     e.preventDefault();
  //   });
  // }

});
