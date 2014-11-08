
var ajaxService = {
  last_update_time: 0,
  setup: function(){
    var self = this;
    window.setInterval(function(){
      console.log("new interval")
      $.ajax({
        type: "GET",
        url: "/",
        data: {
        "last_update_time": self.last_update_time
            },
        contentType: "application/json; charset=utf-8",
        ifModified: true,
        dataType: "json",
        success: function(response, status){
          if(status != "notmodified") {
            $(self).trigger("new-posts", [response]);
            console.log("success ")
            console.log(self.last_update_time)
            self.last_update_time = Date.now();
          }
        }
      });
    }, 5000);
  },

  getNextPosts: function(){
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
