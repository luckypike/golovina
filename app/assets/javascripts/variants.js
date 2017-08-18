Dropzone.autoDiscover = false;

$(function() {
  // Dropzone.prototype.defaultOptions['headers'] = 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content');


  $('.edit_variant .dropzone').each(function() {
    var _this = $(this);
    _this.dropzone({
      url: _this.data('url'),
      paramName: 'image[photo]',
      params: _this.data('params'),
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
    });
  });
});