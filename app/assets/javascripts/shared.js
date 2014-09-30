
var renderPost = function (tweet, bgColor) {
  var postContainer = $(document.createElement("div")).addClass('tweet-container item')

  postContainer.append("<section class='tweet-text'></section>");
  postContainer.find(".tweet-text").text(unescapeHtml(tweet.text));

  postContainer.append("<section class='tweet-username'></section>");
  postContainer.find(".tweet-username").html("<img src='" + tweet.profile_image_url + "' class='avatar' /> @" + tweet.screen_name);  

  postContainer.append("<section class='tweet-picture'></section>");
  if (tweet.media_url){
    postContainer.find(".tweet-picture").html("<img src='" + tweet.media_url + "' />");  
  }


  postContainer.addClass("background-color-"+bgColor);
  postContainer.append("<section class='tweet-created-at'><i class='fa fa-2x fa-"+tweet.source+"'></i>"+tweet.formatted_time_of_post+"</section>");
  return postContainer;
}

function unescapeHtml(safe) {
    return $('<div />').html(safe).text();
}

var create_post_content = function(response) {
  var bgColor = getColorNumber();
  newPosts = [];
  for (var i = 0; i < response.length; i++){
    var postContainer = renderPost(response[i], bgColor);
    newPosts.push(postContainer)
    if (bgColor >= 4){bgColor = 0;}
    bgColor += 1;
  }

    return newPosts;
}

var getColorNumber = function() {
  return Math.floor((Math.random() * 10)) % 4 + 1;
}

var layOutMasonry = function () {
  var masonryList = document.querySelector('#posts-list');
  var msnry = new Masonry(masonryList);
  imagesLoaded( masonryList, function() {
    msnry.layout();
  });

}
