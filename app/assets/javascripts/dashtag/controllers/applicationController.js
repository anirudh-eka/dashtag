"use strict";

var dashtag = dashtag || {}

dashtag.applicationController = function(spec) {
  var that = {};
  var postsHtmlToBeRendered = "";
  var active = false;
  var ajaxService = spec.ajaxService;
  var masonryService = spec.masonryService

  var createPost = function(rawPost) {
    return new Post(rawPost);
  };

  var renderPostsForTop = function() {
    if(!active) {
      if($(window).scrollTop() === 0 && postsHtmlToBeRendered != "1") {
        active = true;
        $('#posts-list').prepend(postsHtmlToBeRendered);
        masonryService.layOutMasonry();
        postsHtmlToBeRendered = "";
        active = false;
      }
    }
  };

  that.setupRenderPost = function() {
    $(ajaxService).on("new-posts", function(e, postsHtml){
      postsHtmlToBeRendered = postsHtml + postsHtmlToBeRendered
      renderPostsForTop();
    })

    $(window).scroll(function() {
      renderPostsForTop();
    });
  };

  that.setupScroll = function () {
    $('#up').on('click', function(e){

      var target= $('#hashtag-anchor');
      $('html, body').stop().animate({
          scrollTop: target.offset().top
      }, 750);
    });
  };

  that.setupLoadOlderPosts = function() {

    $("#load-posts-btn").on("click", function(){
      ajaxService.getOlderPosts();
      $(ajaxService).on("older-posts-loaded", function(e, olderPostsHtml){
        $('#posts-list').append(olderPostsHtml);
        masonryService.layOutMasonry();
      });

      $(ajaxService).on("older-posts-loaded:notmodified", function(){
        $("#loading").empty();
        $("#load-posts-btn").text("There are no more posts!");
      });

    });
  };

  return that;
}
