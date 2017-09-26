$(function() {
  $('.kit .product .product_images .images_list').on('click', function() {
    var _this = $(this);
    var swiper = _this.parent().data('swiper');
    swiper.slideNext();
  });

  $('.as_selectize').selectize();

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
      $(file.previewElement).append('<a rel="nofollow" data-remote="true" data-method="delete" href="' + data.url + '" class="destroy">X</a><img src="' + data.image.photo.preview.url + '">');
      // _this.prev().append('<div class="form_photos_list_item"><a rel="nofollow" data-method="delete" href="' + data.url + '">Удалить</a><img src="' + data.image.photo.drag.url + '"></div>');
    });
  });
});