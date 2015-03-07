"use strict";

var dashtag = dashtag || {}

dashtag.renderPostHelper = function(spec){
	var that = {};
  var dateHelper = spec.dateHelper;

	var renderPost = function (post, bgColor) {
		var postContainer = $(document.createElement("div")).addClass('post-container item')

		postContainer.append("<section class='post-id'></section>");
		postContainer.find(".post-id").html((post.id));

		postContainer.append("<section class='post-text'></section>");
		postContainer.find(".post-text").html((post.text));

		postContainer.append("<section class='post-picture'></section>");
		if (post.media_url) {
				var postImage = "<img src='" + post.media_url + "' />";
				postContainer.find(".post-picture").html(originalPostLink(post, postImage));
		}

		postContainer.append("<section class='post-username'></section>");
		postContainer.find(".post-username").html("<img src='" + post.profile_image_url + "' class='avatar' /><a href='//"
				+ post.source + ".com/" + post.screen_name + "' target='_blank'>@" + post.screen_name + "</a>");

		postContainer.append("<section class='web-intent'></section>");
		if (post.post_id && post.source === 'twitter') {
			var replyLink = "https://twitter.com/intent/tweet?in_reply_to=" + post.post_id;
			var retweetLink = "https://twitter.com/intent/retweet?tweet_id=" + post.post_id;
			var favoriteLink = "https://twitter.com/intent/favorite?tweet_id=" + post.post_id;
			postContainer.find(".web-intent").html("<a href='" + replyLink + "' class= 'reply'></a>" +
																							"<a href='" + retweetLink + "' class= 'retweet'></a>" +
																							"<a href='" + favoriteLink + "' class= 'favorite'></a>");
		}

		var formattedDate = dateHelper.formatDateToLocalTimezone(new Date(post.time_of_post));

		postContainer.addClass("post-color-" + bgColor);

		var createdAtSection = "<i class='fa fa-2x fa-" + post.source + "'></i><span class='time-of-post'>"
				+ formattedDate + "</span>";

		postContainer.append("<section class='post-created-at'>" + originalPostLink(post, createdAtSection) + "</section>");
		return postContainer;
	};

  var getColorNumber = function (index) {
    return Math.floor(Math.random() * 4 + 1);
	};

	var originalPostLink = function (post, createdAtSection) {
    var postLink
    if (post.source === 'twitter') {
        postLink = 'https://twitter.com/' + post.screen_name + '/' + 'status/' + post.post_id;
    }
    if (post.source === 'instagram') {
        postLink = 'https://instagram.com/' + 'p/' + post.post_id;
    }

    return "<a href='" + postLink + "' target='_blank'>" + createdAtSection + "</a>";
  };

	that.createPostContent = function(postsArr) {
    var newPosts = [];
    $.each(postsArr, function(index, postModel){
      var postViewModel = renderPost(postModel, getColorNumber(index));
      newPosts.push(postViewModel);
    });
    return newPosts;
  };

  return that;
}
