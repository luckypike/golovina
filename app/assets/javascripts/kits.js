$(function() {
  $('.kit .product .product_images .images_list').on('click', function() {
    var _this = $(this);
    var swiper = _this.parent().data('swiper');
    swiper.slideNext();
  });

  $('.kits_list_item').on('click', function(){
    var _kpw = $(this).next();
    var _kp = _kpw.find('.kit_products');
    // console.log(_kli);


    if(_kpw.is(':visible')) {
      _kpw.slideUp(400, function() {
        var swiper = _kp.data('swiper');

        if(swiper) {
          swiper.destroy(true, true);
        }
      });

    } else {
      _kpw.slideToggle(400, function() {
        if($(window).width() < 960) {
          var swiper = new Swiper (_kp, {
            freeMode: false,
            slidesPerView: 2,
          });
          _kp.data('swiper', swiper);
        }
      });
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

  $('.as_variants_choose_text input').on('keyup', function() {
    $(this).closest('.as_variants_choose').trigger('redraw');
  });

  // $('.as_selectize_variants').selectize({
  //   valueField: 'id',
  //   labelField: 'title_full',
  //   searchField: 'title_full',
  //   // options: [],
  //   preload: true,
  //   create: false,
  //   render: {
  //     option: function(item, escape) {
  //       // var actors = [];
  //       // for (var i = 0, n = item.abridged_cast.length; i < n; i++) {
  //       //   actors.push('<span>' + escape(item.abridged_cast[i].name) + '</span>');
  //       // }
  //       console.log(item);
  //       return '<div class="selectize-variant">' +
  //         '<div class="img"><img src="' + escape(item.image) + '" alt=""></div>' +
  //         '<div class="data">' +
  //           '<div class="product_label">' + escape(item.title) + '</div>' +
  //           '<div class="color">' + escape(item.color) + '</div>' +
  //         '</div>' +
  //       '</div>';
  //     }
  //   },
  //   load: function(query, callback) {
  //     // if (!query.length) return callback();

  //     // $.ajax({
  //     //     url: this.$input.data('url'),
  //     //     type: 'GET',
  //     //     error: function() {
  //     //         callback();
  //     //     },
  //     //     success: function(res) {
  //     //         callback(res.variants);
  //     //     }
  //     // });

  //     console.log(this.$input.data('url'));

  //     $.getJSON(this.$input.data('url'), {
  //         q: query,
  //       })
  //       .done(function(data) {
  //         // console.log(data.variants);
  //         return callback(data.variants);
  //       })
  //       .fail(function() {
  //         return callback();
  //     });
  //   }
  // });

  $('.dz_preview').on('ajax:success', '.destroy', function(event) {
    var detail = event.detail;
    var data = detail[0], status = detail[1],  xhr = detail[2];
    console.log(detail);
    if(xhr.status == 200) {
      var id = $(this).closest('.dz_preview_item').data('id');

      var _images = $(this).closest('.dz_form').find('.dz_images');

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
      // var _this = $(this);
      // console.log(file);
      // console.log(response);
      var images = JSON.parse(_images.val());
      images.push(data.image.id);
      _images.val(JSON.stringify(images));

      $(file.previewElement).data('id', data.image.id)
      $(file.previewElement).append('<div class="pos" data-pos="' + data.image.weight + '"><input type="hidden" name="kit[images_attributes][' + data.image.id + '][weight]" value="0" class="pos_value"><input type="hidden" name="kit[images_attributes][' + data.image.id + '][id]" value="' + data.image.id + '"><div class="l"></div></div><img src="' + data.image.photo.preview.url + '"><div class="control"><a rel="nofollow" data-remote="true" data-method="delete" href="' + data.url + '" class="destroy"></a></div>');
      // _this.prev().append('<div class="form_photos_list_item"><a rel="nofollow" data-method="delete" href="' + data.url + '">Удалить</a><img src="' + data.image.photo.drag.url + '"></div>');
    });
  });

  var _dzp = $('.dz_preview');

  _dzp.on('click', '.dz_preview_item', function(event) {
    var _this = $(this);
    var _pos = $('.pos', this)


    var pos = parseInt(_pos.data('pos'));
    if(pos > 0) {
      $('.pos', _dzp).each(function(i, el) {
        var _el = $(el);
        var cpos = _el.data('pos');
        if(cpos > pos) {
          _el.data('pos', cpos - 1);
        }
      });

      _dzp.data('max', _dzp.data('max') - 1);

      pos = 0;


    } else {
      pos = _dzp.data('max');
      pos = pos + 1;
      _dzp.data('max', pos);
    }

    _pos.data('pos', pos);

    _dzp.trigger('redraw');
  });

  _dzp.on('redraw', function() {
    $('.dz_preview_item', _dzp).each(function(i, el) {
      var _el = $(el);
      var _pos = $('.pos', el);
      var pos = _pos.data('pos');

      $('.pos_value', _pos).val(pos);


      if(pos < 1) {
        $('.l', _pos).html('');
      } else {
        $('.l', _pos).html(_pos.data('pos'));
      }

    });
  });

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

