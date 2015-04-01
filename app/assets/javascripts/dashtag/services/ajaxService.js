"use strict";

var dashtag = dashtag || {}

dashtag.ajaxService = function() {
  var that = {};
  var last_update_time = Date.now();

  var getLastPostId = function(){
    return $("#posts-list").find(".post-id").last().text();
  };

  that.setup = function(){
    var loop = function(){

      $.ajax({
        type: "GET",
        url: "/get_new_posts",
        data: {
        "last_update_time": last_update_time
            },
        contentType: "application/html; charset=utf-8",
        ifModified: true,
        dataType: "html",
        success: function(response, status){
          if(status != "notmodified") {
            $(that).trigger("new-posts", response);
            last_update_time = Date.now();
          }
        },
        complete: function() {
          setTimeout(loop, 5000);
        }
      });
    };
    loop();
  };

  that.getOlderPosts = function(){
    $.ajax({
      type: "GET",
      url: "/get_older_posts",
      data: {
        "last_post_id": getLastPostId()
            },
      contentType: "application/html; charset=utf-8",
      ifModified: true,
      dataType: "html",
      success: function(response, status){
        if(status != "notmodified") {
          $(that).trigger("older-posts-loaded", response);
        }
        else{
          $(that).trigger("older-posts-loaded:notmodified");
        }
      }
    });
  };

  return that;
}



