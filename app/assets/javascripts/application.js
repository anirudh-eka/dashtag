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
      console.log("sent request!!")
      $.ajax({
        type: "GET",
        url: "/",
        contentType: "application/json; charset=utf-8",
        ifModified: true,
        dataType: "json",
        success: function(response, status){
          if(status != "notmodified") {
            console.log("SUCCESS!!")
            console.log(response)
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

function Post(id, text, media_url, screen_name, profile_image_url, source, time_of_post) {
  this.id = id;
  this.text = text;
  this.media_url = media_url;
  this.screen_name = screen_name;
  this.profile_image_url = profile_image_url;
  this.source = source;
  this.timeOfPost = time_of_post;
}

var controller = {
  setupRenderPost: function() {
    var self = this;

    var newPostsArr = [];
    console.log("newPostsArr");
    console.log(newPostsArr);

    $(service).on("new-posts", function(e, rawPostData){

      $.each(rawPostData, function(index, rawPost){
        newPostsArr.push(self.createPost(rawPost));
      });

      console.log("newPostsArr");
      console.log(newPostsArr);

      var newPosts = self.createPostContent(newPostsArr);
      $('#posts-list').prepend(newPosts);
      layOutMasonry();

    })
  },

  createPost: function(rawPost) {
    return new Post(rawPost.id, rawPost.text, rawPost.media_url, rawPost.screen_name, rawPost.profile_image_url, rawPost.source, rawPost.formatted_time_of_post)
  },

  createPostContent: function(postsArr) {
    console.log("createPostContent")
    var bgColor = getColorNumber();
    var newPosts = [];
    var theLength = postsArr.length;
    for (var i = 0; i < theLength ; i++) {
        var postContainer = this.renderPost(postsArr.pop(), bgColor);
        newPosts.push(postContainer);
        if (bgColor >= 4) {
            bgColor = 0;
        }
        bgColor += 1;
    }
    return newPosts;
  },

  renderPost: function (post, bgColor) {
    var postContainer = $(document.createElement("div")).addClass('post-container item')

    postContainer.append("<section class='post-id'></section>");
    postContainer.find(".post-id").html((post.id));

    postContainer.append("<section class='post-text'></section>");
    postContainer.find(".post-text").html((post.text));

    postContainer.append("<section class='post-picture'></section>");
    if (post.media_url) {
        var postImage = "<img src='" + post.media_url + "' />";
        postContainer.find(".post-picture").html(originalPostLink(post, postImage));
    }

    postContainer.append("<section class='post-username'></section>");
    postContainer.find(".post-username").html("<img src='" + post.profile_image_url + "' class='avatar' /><a href='//"
        + post.source + ".com/" + post.screen_name + "' target='_blank'>@" + post.screen_name + "</a>");

    var formattedDate = formatDateHelper.formatDateToLocalTimezone(new Date(post.timeOfPost));

    postContainer.addClass("background-color-" + bgColor);

    var createdAtSection = "<i class='fa fa-2x fa-" + post.source + "'></i><span class='time-of-post'>"
        + formattedDate + "</span>";

    postContainer.append("<section class='post-created-at'>" + originalPostLink(post, createdAtSection) + "</section>");

    return postContainer;
  },

  setupInfinteScroll: function() {
    var self = this;
    $("#load-posts-btn").on("click", function(){
      $("#loading").empty()
      $("#loading").append("<i class='fa fa-spinner faa-spin animated'></i>")
      service.getNextPosts();
      $(service).on("next-posts", function(e, data){
        $("#loading").empty();
        var newPosts = self.createPostContent(data);
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

  formatDateHelper.replaceInitiallyLoadedTimestamps();

  setUpScroll();

  service.setup();

  controller.setupRenderPost();

  controller.setupInfinteScroll();
});

