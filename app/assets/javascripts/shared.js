
var renderPost = function (post, bgColor) {
  var postContainer = $(document.createElement("div")).addClass('post-container item')

  postContainer.append("<section class='post-id'></section>");
  postContainer.find(".post-id").text(unescapeHtml(post.id));

  postContainer.append("<section class='post-text'></section>");
  postContainer.find(".post-text").text(unescapeHtml(post.text));

  postContainer.append("<section class='post-username'></section>");
  postContainer.find(".post-username").html("<img src='" + post.profile_image_url + "' class='avatar' /> @" + post.screen_name);  

  postContainer.append("<section class='post-picture'></section>");
  if (post.media_url){
    postContainer.find(".post-picture").html("<img src='" + post.media_url + "' />");  
  }

  var formattedDate = formatDateToLocalTimezone(new Date(post.formatted_time_of_post));

  postContainer.addClass("background-color-"+bgColor);
  postContainer.append("<section class='post-created-at'><i class='fa fa-2x fa-"+post.source+"'></i>" + formattedDate  +"</section>");
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
