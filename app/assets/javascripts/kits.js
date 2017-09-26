$(function() {
  $('.kit .product .product_images .images_list').on('click', function() {
    var _this = $(this);
    var swiper = _this.parent().data('swiper');
    swiper.slideNext();
  });

  $('.as_selectize').selectize();


  $('.dz_form').each(function() {
    var _this = $(this);
    var dz = new Dropzone(_this.get(0), {
      url: _this.data('url'),
      paramName: 'image[photo]',
      params: _this.data('params'),
      previewsContainer: '.dz_preview',
      clickable: '.dz_clickable',
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
    });

    dz.on('success', function(file, data) {
      // var _this = $(this);
      // console.log(file);
      // console.log(response);
      _this.prev().append('<div class="form_photos_list_item"><a rel="nofollow" data-method="delete" href="' + data.url + '">Удалить</a><img src="' + data.image.photo.drag.url + '"></div>');
    });
  });
});