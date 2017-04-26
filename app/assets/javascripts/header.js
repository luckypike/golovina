$(function() {
  $('.header_burger').on('click', function() {
    $('.header').toggleClass('with-nav');

  });

  $('nav.nav .hn').on('click', function(){

    if($(this).next().is('.active')) {
      $(this).next().slideToggle().toggleClass('active');
    } else {
      $('.nav_box_sg.active').slideUp().removeClass('active ');
      $(this).next().slideToggle().toggleClass('active');
    }

  });
});