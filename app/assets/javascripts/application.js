// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).on("ready", function(){
  var container = document.querySelector('#container');
  var msnry = new Masonry(container);
  // layout Masonry again after all images have loaded
  imagesLoaded( container, function() {
    msnry.layout();
  });


  window.setInterval(function(){
    $.ajax({
      type: "GET",
      url: "/",
      contentType: "application/json; charset=utf-8",
      ifModified: true,
      dataType: "json",
      success: function(data, status){
        console.log(data);
        console.log(status);
        if(status != "notmodified") {
          $("#container").empty();
          var bgColor = 0;
          for (var i = 0; i < data.length; i++){
            bgColor += 1;
            var obj = data[i];
            var tweet = new Tweet(obj.text, obj.screen_name, obj.created_at_formatted, obj.profile_image_url, obj.media_url);
            render(tweet).addClass("background-color-"+bgColor);
            if(bgColor == 4) { bgColor = 0 }
          }
            var container = document.querySelector('#container');
            var msnry = new Masonry(container);
            imagesLoaded( container, function() {
                msnry.layout();
            });
        }          
      }
    });
  }, 2000);

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
  var container = $("#container")
  container.append("<div class='tweet-container'></div>")
  var tweetContainer = container.find(".tweet-container").last()

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
