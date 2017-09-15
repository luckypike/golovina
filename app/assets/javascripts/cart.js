$(function() {
  $('.summary_form form').on('ajax:success', function(event) {
    var _this = $(this);
    var detail = event.detail;
    var data = detail[0], status = detail[1],  xhr = detail[2];
    if(data.status == 'unprocessable_entity') {
      if(data.error.common != undefined) {
        $('.form_errors', _this).html(data.error.common);
      } else {
        if(data.error.phone != undefined) {
          $('.form_errors', _this).html('Данный телефон уже используется. Нужно сначала войти.');
        }
        if(data.error.email != undefined) {
          $('.form_errors', _this).html('Данная эл. почта уже используется. Нужно сначала войти.');
        }
      }

    } else {
      $('.page_cart_items').slideUp(400, function() {
        $(this).remove();
        $('.page_cart_title').after('<div class="page_cart_success">Заказ сформирован и отправлен нашим менеджерам. Мы свяжемся с вами в ближайшее время.</div>');
      });
    }
  });
});