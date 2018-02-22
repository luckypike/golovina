// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require cocoon
//= require dropzone/dist/dropzone

//= require swiper/dist/js/swiper.jquery

//= require selectize/dist/js/standalone/selectize
//= require jquery-mask-plugin/dist/jquery.mask.min
//= require cleave.js/dist/cleave.min.js

//= require sticky-kit/dist/sticky-kit.min

//= require_tree .

Dropzone.autoDiscover = false;

function setupDragon(uploader) {
    /* A little closure for handling proper
       drag and drop hover behavior */
    var dragon = (function (elm) {
      var dragCounter = 0;

      return {
        enter: function (event) {
          event.preventDefault();
          dragCounter++;
          elm.classList.add('dz-drag-hover')
        },
        leave: function (event) {
          dragCounter--;
          if (dragCounter === 0) {
            elm.classList.remove('dz-drag-hover')
          }
        }
      }
    })(uploader.element);

    uploader.on('dragenter', dragon.enter);
    uploader.on('dragleave', dragon.leave);
}


// $('.as_cleave_phone').mask('+7 000 000-00-00');

$(function() {
  $('.as_cleave_phone').toArray().forEach(function(field){
    console.log(field);
    new Cleave(field, {
      numericOnly: true,
      prefix: '+7',
      delimiters: [' ', ' ', '-', '-'],
      blocks: [2, 3, 3, 2, 2]
    });
  });
});
