var dashtag = dashtag || {}

dashtag.ajaxService = function() {
  var that = {};
  var last_update_time = Date.now();

  var ajaxLoop = function(){
    $.ajax({
      type: "GET",
      url: "/",
      data: {
      "last_update_time": that.last_update_time
          },
      contentType: "application/json; charset=utf-8",
      ifModified: true,
      dataType: "json",
      success: function(response, status){
        if(status != "notmodified") {
          $("#posts-list").trigger("new-posts", [response]);
          that.last_update_time = Date.now();
        }
      },
      complete: function() {
        setTimeout(ajaxLoop, 5000);
      }
    });
  };

  var getLastPostId = function(){
    return $("#posts-list").find(".post-id").last().text();
  };

  that.setup = function(){
    ajaxLoop();
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
          $("#posts-list").trigger("next-posts", [response]);
        }
        else{
          $("#posts-list").trigger("next-posts:notmodified");
        }
      }
    });
  };

  return that;
}



