$(window).scroll(function() {
   if($(window).scrollTop() + $(window).height() == $(document).height()) {
      $("#loading").empty() 
      $("#loading").append("<i class='fa fa-spinner faa-spin animated'></i>")
		 $.ajax({
      type: "GET",
      url: "/get_next_page",
      data: { 
        "last_post_id": getLastPostId()
            },
      contentType: "application/json; charset=utf-8",
      ifModified: true,
      dataType: "json",
      success: function(data, status){
        if(status != "notmodified") {
          $("#loading").empty();
          var newPosts = create_post_content(data);
          $('#posts-list').append(newPosts);
          layOutMasonry();
        	}          
      	}
    	});
   }
});

function getLastPostId() {
  return $("#posts-list").find(".tweet-id").last().text();
}