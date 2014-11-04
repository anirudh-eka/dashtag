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
  },

  getNextPosts: function(){
    console.log("get next post is called")
    var self = this;
    $.ajax({
      type: "GET",
      url: "/get_next_page",
      data: {
        "last_post_id": self.getLastPostId()
            },
      contentType: "application/json; charset=utf-8",
      ifModified: true,
      dataType: "json",
      success: function(response, status){
        console.log(status)

        if(status != "notmodified") {
          $(self).trigger("next-posts", [response]);
        }
        else{
          $(self).trigger("next-posts:notmodified");
        }
      }
    });
  },
  getLastPostId: function(){
    return $("#posts-list").find(".post-id").last().text();
  }

}

var controller = {
  setupRenderPost: function() {
    $(service).on("new-posts", function(e, data){
      var newPosts = create_post_content(data);
          $('#posts-list').prepend(newPosts);
          layOutMasonry();
    })
  },

  setupInfinteScroll: function() {
    $("#load-posts-btn").on("click", function(){
      console.log("clicked")
      $("#loading").empty()
      $("#loading").append("<i class='fa fa-spinner faa-spin animated'></i>")
      service.getNextPosts();
      $(service).on("next-posts", function(e, data){
        console.log("heard it!");
        $("#loading").empty();
        var newPosts = create_post_content(data);
        $('#posts-list').append(newPosts);
        layOutMasonry();
      });

      $(service).on("next-posts:notmodified", function(){
        console.log("this is the end");
        $("#loading").empty();
        $("#load-posts-btn").text("There are no more posts!");
      });

    });
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

  controller.setupInfinteScroll();
});

