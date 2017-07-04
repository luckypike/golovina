$(function(){
  $('.color, .size').on('click', function() {
    $('.color, .size').not(this).removeClass('active');
    $(this).toggleClass('active');
  });

  $('.fd_i').on('click', '.t', function() {
    var _fdi = $(this).parent();
    $('.fd_d').not(_fdi).removeClass('fd_d');
    _fdi.toggleClass('fd_d', !_fdi.is('.fd_d'));
    $('.fd_l .f.' + _fdi.data('f')).toggleClass('fa', _fdi.is('.fd_d'));

  });

  $('.fd_w').on('mouseleave', function() {
    var _fdi = $('.fd_i.fd_d', this);
    $('.t', _fdi).trigger('click');
  });
});
