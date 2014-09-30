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

$(document).on("ready", function(){
  var postsList = document.querySelector('#posts-list');
  // layout Masonry again after all images have loaded
      var msnry = new Masonry(postsList);
      imagesLoaded( postsList, function() {
          msnry.layout();
      });

  replaceInitiallyLoadedTimestamps();

  setUpScroll();

  window.setInterval(function(){
    $.ajax({
      type: "GET",
      url: "/",
      contentType: "application/json; charset=utf-8",
      ifModified: true,
      dataType: "json",
      success: function(response, status){
        if(status != "notmodified") {
          var newPosts = create_post_content(response);
          $('#posts-list').prepend(newPosts);
          layOutMasonry();
        }
      }
    });
  }, 5000);
});

var formatDateToLocalTimezone = function(timestamp) {
    var date = timestamp.toString().substring(0, 11);
    return date.concat(timestamp.toLocaleTimeString());
}

var replaceInitiallyLoadedTimestamps = function() {
  var timestamps = $(".tweet-created-at");

  for(var i=0; i< timestamps.length-1 ; i++) {
    var timestamp = new Date($(timestamps[i]).text().trim());
    $(timestamps[i]).text(formatDateToLocalTimezone(timestamp));
  }
}

var setUpScroll = function () {$('#up').on('click', function(e){
    e.preventDefault();
    var target= $('#hashtag-anchor');
    $('html, body').stop().animate({
        scrollTop: target.offset().top
    }, 750);
})};

