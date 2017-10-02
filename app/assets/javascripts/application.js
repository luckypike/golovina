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

//= require vivus

//= require dropzone/dist/dropzone

//= require swiper/dist/js/swiper.jquery

//= require selectize/dist/js/standalone/selectize
//= require jquery-mask-plugin/dist/jquery.mask.min

//= require_tree .


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