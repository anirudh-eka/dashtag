// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require shared
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require imagesloaded.pkgd
//= require_tree .




var setUpScroll = function () {$('#up').on('click', function(e){
    e.preventDefault();
    var target= $('#hashtag-anchor');
    $('html, body').stop().animate({
        scrollTop: target.offset().top
    }, 750);
})};

var service = {
  setup: function(){
    var self = this;
    window.setInterval(function(){
      $.ajax({
        type: "GET",
        url: "/",
        contentType: "application/json; charset=utf-8",
        ifModified: true,
        dataType: "json",
        success: function(response, status){
          if(status != "notmodified") {
            $(self).trigger("new-posts", [response]);
          }
        }
      });
    }, 5000);
  }
}

var controller = {
  setupRenderPost: function() {
    $(service).on("new-posts", function(e, data){
      var newPosts = create_post_content(data);
          $('#posts-list').prepend(newPosts);
          layOutMasonry();
    })
  }
}

$(document).on("ready", function(){
  var postsList = document.querySelector('#posts-list');
  // layout Masonry again after all images have loaded
      var msnry = new Masonry(postsList);
      imagesLoaded( postsList, function() {
          msnry.layout();
      });

  replaceInitiallyLoadedTimestamps();

  setUpScroll();

  service.setup();

  controller.setupRenderPost();
});

