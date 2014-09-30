$(window).scroll(function() {
   if($(window).scrollTop() + $(window).height() == $(document).height()) {
      $("#loading").empty() 
      $("#loading").append("<i class='fa fa-spinner faa-spin animated'></i>")

		 $.ajax({
      type: "GET",
      url: "/get_next_page",
      data: { 
        "last_page_requested": $('#last_post_id').text()
            },
      contentType: "application/json; charset=utf-8",
      ifModified: true,
      dataType: "json",
      success: function(data, status){
        if(status != "notmodified") {
          set_page();
          var newPosts = create_post_content(data);
          $('#posts-list').append(newPosts);
          layOutMasonry();
        	}          
      	}
    	});
   }
});


function set_page() {
  $("#loading").empty();
  var next = parseInt($('#last_post_id').text()) + 1;
  console.log(next)
  $('#last_post_id').text(next);
}