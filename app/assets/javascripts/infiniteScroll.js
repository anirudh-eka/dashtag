$(window).scroll(function() {
   if($(window).scrollTop() + $(window).height() == $(document).height()) {
      $("#loading").empty() 
      $("#loading").append("<i class='fa fa-spinner faa-spin animated'></i>")


		 $.ajax({
      type: "GET",
      url: "/get_next_page",
      data: { 
        "last_page_requested": $('#last_page_requested').text()
            },
      contentType: "application/json; charset=utf-8",
      ifModified: true,
      dataType: "json",
      success: function(data, status){
        if(status != "notmodified") {
          
          $("#loading").empty()
          var next = parseInt($('#last_page_requested').text()) + 1
          $('#last_page_requested').text(next)

          var bgColor = 0;
          for (var i = 0; i < data.length; i++){
            bgColor += 1;
            var obj = data[i];
            var tweet = new Tweet(obj.text, obj.screen_name, obj.created_at_formatted, obj.profile_image_url, obj.media_url);
            render(tweet).addClass("background-color-"+bgColor);
            if(bgColor == 4) { bgColor = 0 }
          }
            var posts_list = document.querySelector('#posts-list');
            var msnry = new Masonry(posts_list);
            imagesLoaded( posts_list, function() {
                msnry.layout();
            });
        	}          
      	}
    	});



   }
});

function Tweet(text, screen_name, created_at, profile_image_url, media_url) {
  return {
    text: text,
    screen_name: screen_name,
    created_at: created_at,
    profile_image_url: profile_image_url,
    media_url: media_url
  };
}

function render(tweet) {
  var posts_list = $("#posts-list")
  posts_list.append("<div class='tweet-container'></div>")
  var tweetContainer = posts_list.find(".tweet-container").last()

  tweetContainer.append("<section class='tweet-text'></section>");
  tweetContainer.find(".tweet-text").text(tweet.text);

  tweetContainer.append("<section class='tweet-username'></section>");
  tweetContainer.find(".tweet-username").html("<img src='" + tweet.profile_image_url + "' class='avatar' /> @" + tweet.screen_name);  

  tweetContainer.append("<section class='tweet-picture'></section>");
  if (tweet.media_url){
    tweetContainer.find(".tweet-picture").html("<img src='" + tweet.media_url + "' />");  
  }

  tweetContainer.append("<section class='tweet-created-at'></section>");
  tweetContainer.find(".tweet-created-at").text(tweet.created_at);
  return tweetContainer;
}