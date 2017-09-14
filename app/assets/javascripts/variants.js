Dropzone.autoDiscover = false;

$(function() {
  // Dropzone.prototype.defaultOptions['headers'] = 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content');


  $('.edit_variant .dropzone').each(function() {
    var _this = $(this);
    var dz = new Dropzone(_this.get(0), {
      url: _this.data('url'),
      paramName: 'image[photo]',
      params: _this.data('params'),
      dictDefaultMessage: "Перетащите сюда фотографии товаров",
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

  $('.page_product_form_variants_variant .toggle').on('click', function() {
    $(this).next().toggle();
  });

  $('.page_product_form_variants_variant').each(function() {
    var _this = $(this);
    if(_this.find('.error_notification').length) {
      $('.form', _this).show();
    }
  });

  $('form.edit_variant').on('ajax:success', function(event) {
    var detail = event.detail;
    var data = detail[0], status = detail[1],  xhr = detail[2];
    var _form = $(this).find('.form_inputs');
    _form.find('h3').text($('.variant_color select option:selected', _form).text());
  });

  $('.form_photos_list').on('change', '.image_weight', function() {
    $.ajax({
      url: $('.form_photos_list').data('weight'),
      type: 'post',
      data: {
        id: $(this).data('id'),
        weight: $(this).val(),
      },
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
    });

    return false;
  });

  // var drake = dragula({
  //   direction: 'horizontal',
  // });

  // drake.on('drop', function(el, target, source, sibling) {
  //   console.log(el);
  // });

  // var _fpl = $('.form_photos_list');

  // if(_fpl.length) {
  //   drake.containers.push(_fpl[0]);
  // }
});