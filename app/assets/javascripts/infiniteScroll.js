$(window).scroll(function() {
   if($(window).scrollTop() + $(window).height() == $(document).height()) {
      $("#loading").empty()
      $("#loading").append("<i class='fa fa-spinner faa-spin animated'></i>")

   }
});

// function getLastPostId() {
//   return $("#posts-list").find(".post-id").last().text();
// }
