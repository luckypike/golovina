Dropzone.autoDiscover = false;

$(function() {
  // Dropzone.prototype.defaultOptions['headers'] = 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content');


  $('.edit_variant .dropzone').each(function() {
    var _this = $(this);
    var dz = new Dropzone(_this.get(0), {
      url: _this.data('url'),
      paramName: 'image[photo]',
      params: _this.data('params'),
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
    });

    dz.on('success', function(file, data) {
      // console.log(file);
      // console.log(response);
      $('.form_photos_list').append('<div class="form_photos_list_item"><a rel="nofollow" data-method="delete" href="' + data.url + '">Удалить</a><img src="' + data.image.photo.drag.url + '"></div>');
    });
  });
});