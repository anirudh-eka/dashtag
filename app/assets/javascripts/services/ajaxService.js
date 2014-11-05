var ajaxService = {
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
