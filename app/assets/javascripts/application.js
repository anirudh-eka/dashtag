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
//= require shared
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require imagesloaded.pkgd
//= require_tree .

$(document).on("ready", function(){
  var postsList = $('#posts-list');
  // layout Masonry again after all images have loaded
    postsList.imagesLoaded(function () {
      postsList.masonry();
  });

  setUpScroll();

  window.setInterval(function(){
    $.ajax({
      type: "GET",
      url: "/",
      contentType: "application/json; charset=utf-8",
      ifModified: true,
      dataType: "json",
      success: function(data, status){
        if(status != "notmodified") {
          for (var postNumber = 0; postNumber < data.length; postNumber++){
            var postColor = (postNumber % 4) + 1;
            var obj = data[postNumber];
            var tweet = new Tweet(obj.text, obj.screen_name, obj.created_at_formatted, obj.profile_image_url, obj.media_url);
            var lastPost = render(tweet);
            lastPost.addClass("background-color-"+postColor);
            lastPost.addClass("item");
            $(postsList).prepend(lastPost);
            $(postsList).masonry('reloadItems');
            postsList.imagesLoaded(function () {
                postsList.masonry();
            })
          }
        }
      }
    });
  }, 5000);
});

var setUpScroll = function () {$('#up').on('click', function(e){
    e.preventDefault();
    var target= $('#hashtag-anchor');
    $('html, body').stop().animate({
        scrollTop: target.offset().top
    }, 750);
})};

function render(tweet) {

  var tweetContainer = $("<div class='tweet-container'></div>")

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


