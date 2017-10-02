$(function() {
  var _h = $('.header');
  var _b = $('body');

  var _hb = $('.header_burger');

  _hb.on('click', function() {
    _h.toggleClass('with_nav');
    _b.toggleClass('full_screen');
  }).trigger('click1');


  $('.header_overlay, .header_menu_close').on('click', function() {
    _h.removeClass('with_nav with_cart');
    _b.removeClass('full_screen');
  });

  $('.header_menu_section .section_title').on('click', function() {
    var _this = $(this).next();
    $('.header_menu_section .section_list').not(_this).not(_this.parents('.section_list')).slideUp();
    _this.slideToggle();
  });

  var _window = $(window);

  _window.on('scroll', function() {
    if(_window.scrollTop() > 3) {
      if(!_h.is('.no_hide_logo')) {
        _h.addClass('hide_logo');
      }
    } else {
      _h.removeClass('hide_logo no_themes');
    }
  }).trigger('scroll');

  var _ca = $('.cart a', _h);

  _ca.on('click', function() {
    if(_h.width() > 960 && _ca.parent().is('.active')) {

      var _this = $(this);
      var src = _this.data('src');

      _h.toggleClass('with_cart');
      _b.toggleClass('full_screen');

      $.getJSON(src, function(data) {
        var _hci = $('.header_cart_items');
        _hci.html('');
        $.each(data.items, function(i, e) {
          _hci.append('<div class="header_cart_items_item"><div class="image"><img src="' + e.image + '"></div><div class="title">' + e.title + '</div><div class="color_and_size">' + e.color + ' |  ' + e.size + '</div><div class="price">' + e.price + '</div></div>');
        });

        $('.header_cart_sum').html(data.sum);
      });
      return false;
    } else {
      if(!_ca.parent().is('.active')) {
        return false;
      }
    }



  }).trigger('click1');

  $('.header_cart .close').on('click', function() {
    _ca.trigger('click');
  });
});