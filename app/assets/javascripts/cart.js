$(function() {
  $('.cart_destroy').on('ajax:success', function(event) {
    var _this = $(this);
    var detail = event.detail;
    var data = detail[0], status = detail[1],  xhr = detail[2];

    if(xhr.status == 200) {
      var _ii = _this.closest('.items_item');
      _ii.slideUp(function() {
        _ii.remove();
      });
    }

  });

  $('.summary_form form').on('ajax:success', function(event) {
    var _this = $(this);
    var detail = event.detail;
    var data = detail[0], status = detail[1],  xhr = detail[2];
    if(data.status == 'unprocessable_entity') {

      $('.input_error', _this).remove();

      $.each(data.error, function(i, e) {
        var _f = $('.user_' + i, _this);

        var text = e[0];
        _f.append('<div class="input_error">' + text + '</div>');
        // $('.form_errors', _this)
        console.log(i);
        console.log(e[0]);

        // for (var i = 0, len = e.length; i < len; i++) {
        //   console.log(e[i].error);
        // }
      });

      // if(.common != undefined) {
      //   $('.form_errors', _this).html(data.error.common);
      // } else {
      //   if(data.error.phone != undefined) {
      //     $('.form_errors', _this).html('Данный телефон уже используется. Нужно сначала войти.');
      //   }
      //   if(data.error.email != undefined) {
      //     $('.form_errors', _this).html('Данная эл. почта уже используется. Нужно сначала войти.');
      //   }
      // }

    } else {
      $('.page_cart_items').slideUp(400, function() {
        $(this).remove();
        $('.page_cart_title').after('<div class="page_cart_success">Заказ сформирован и отправлен нашим менеджерам. Мы свяжемся с вами в ближайшее время.</div>');
      });
    }
  });
});
