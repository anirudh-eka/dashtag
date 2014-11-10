
var ajaxService = {
  last_update_time: Date.now(),
  // setup: function(){
  //   var self = this;
  //   window.setInterval(function(){
  //     $.ajax({
  //       type: "GET",
  //       url: "/",
  //       data: {
  //       "last_update_time": self.last_update_time
  //           },
  //       contentType: "application/json; charset=utf-8",
  //       ifModified: true,
  //       dataType: "json",
  //       success: function(response, status){
  //         console.log(status)
  //         if(status != "notmodified") {
  //           $(self).trigger("new-posts", [response]);
  //           console.log(response)
  //           self.last_update_time = Date.now();
  //         }
  //       }
  //     });
  //   }, 5000);
  // },

  setup: function(){
    var self = this;
    var loop = function(){
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
          console.log(status)
          if(status != "notmodified") {
            $(self).trigger("new-posts", [response]);
            console.log(response)
            self.last_update_time = Date.now();
          }
        },
        complete: function() {
          setTimeout(loop, 5000);
        }
      });
    };
    loop();
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
