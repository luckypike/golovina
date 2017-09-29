$(function() {
  $('.request_code').on('ajax:success', function(event){
    var detail = event.detail;
    var data = detail[0], status = detail[1],  xhr = detail[2];

    var _this = $(this);

    var _lwc = $('.login_with_code');


    if(1) {
      _lwc.show();
      _this.hide();

      _lwc.find('.as_cleave_phone').val(_this.find('.as_cleave_phone').val());
      // _lwc.find('.user_code').focus();
      // console.log(_this.find('.as_cleave_phone').cleanVal());

      // _cl.setRawValue(_this.find('.as_cleave_phone').val().replace(/\D/g,''))
    }


    // var tel = _this.closest('form').find('.as_cleave_phone').val().replace(/\D/g,'');
    // event.detail[1].data = 'phone=' + tel;
    // console.log(event.detail[1].data);
  });
});