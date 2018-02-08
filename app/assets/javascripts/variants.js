$(function() {

  $('.dz_form_variant').mint_dropzone_variant();

  $('.form_inputs_variants')
    .on('cocoon:before-insert', function(e, variant_to_be_added) {
      variant_to_be_added.mint_dropzone_variant();
    });


});


(function($){
  $.fn.mint_dropzone_variant = function() {
    return this.each(function() {
      var _this = $(this);
      var _images = _this.find('.dz_images');
        var dz = new Dropzone(_this.get(0), {
        url: _this.data('url'),
        dragenter: function () {},
        dragleave: function () {},
        init: function () { setupDragon(this) },

        paramName: 'image[photo]',
        params: _this.data('params'),
        previewsContainer: $('.dz_preview', this).get(0),
        previewTemplate: '<div class="dz_preview_item"></div>',
        clickable: $('.dz_clickable', this).get(0),
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }
      });

      dz.on('success', function(file, data) {
        var images = JSON.parse(_images.val());
        images.push(data.image.id);
        _images.val(JSON.stringify(images));
        console.log(file.previewElement);

        $(file.previewElement).data('id', data.image.id)
        $(file.previewElement).append('<div class="pos" data-pos="' + data.image.weight + '"><input type="hidden" name="kit[images_attributes][' + data.image.id + '][weight]" value="0" class="pos_value"><input type="hidden" name="kit[images_attributes][' + data.image.id + '][id]" value="' + data.image.id + '"><div class="l"></div></div><img src="' + data.image.photo.preview.url + '"><div class="control"><a rel="nofollow" data-remote="true" data-method="delete" href="' + data.url + '" class="destroy"></a></div>');
      });
    });

    // return this;
  };
}(jQuery));
