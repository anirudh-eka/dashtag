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
        url: "/",
        data: {
        "last_update_time": last_update_time
            },
        contentType: "application/json; charset=utf-8",
        ifModified: true,
        dataType: "json",
        success: function(response, status){
          if(status != "notmodified") {
            $(that).trigger("new-posts", [response]);
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

  that.getNextPosts = function(){
    $.ajax({
      type: "GET",
      url: "/get_next_page",
      data: {
        "last_post_id": getLastPostId()
            },
      contentType: "application/json; charset=utf-8",
      ifModified: true,
      dataType: "json",
      success: function(response, status){
        if(status != "notmodified") {
          $(that).trigger("next-posts", [response]);
        }
        else{
          $(that).trigger("next-posts:notmodified");
        }
      }
    });
  };

  return that;
}



