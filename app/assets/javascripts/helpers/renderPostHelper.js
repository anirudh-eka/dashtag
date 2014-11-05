var renderPostHelper = {
	renderPost: function (post, bgColor) {
		var postContainer = $(document.createElement("div")).addClass('post-container item')

		postContainer.append("<section class='post-id'></section>");
		postContainer.find(".post-id").html((post.id));

		postContainer.append("<section class='post-text'></section>");
		postContainer.find(".post-text").html((post.text));

		postContainer.append("<section class='post-picture'></section>");
		if (post.media_url) {
				var postImage = "<img src='" + post.media_url + "' />";
				postContainer.find(".post-picture").html(this.originalPostLink(post, postImage));
		}

		postContainer.append("<section class='post-username'></section>");
		postContainer.find(".post-username").html("<img src='" + post.profile_image_url + "' class='avatar' /><a href='//"
				+ post.source + ".com/" + post.screen_name + "' target='_blank'>@" + post.screen_name + "</a>");

		var formattedDate = dateHelper.formatDateToLocalTimezone(new Date(post.timeOfPost));

		postContainer.addClass("background-color-" + bgColor);

		var createdAtSection = "<i class='fa fa-2x fa-" + post.source + "'></i><span class='time-of-post'>"
				+ formattedDate + "</span>";

		postContainer.append("<section class='post-created-at'>" + this.originalPostLink(post, createdAtSection) + "</section>");

		return postContainer;
	},

	createPostContent: function(postsArr) {
    console.log("createPostContent")
    var bgColor = this.getColorNumber();
    var newPosts = [];
    var theLength = postsArr.length;
    for (var i = 0; i < theLength ; i++) {
        var postContainer = renderPostHelper.renderPost(postsArr.pop(), bgColor);
        newPosts.push(postContainer);
        if (bgColor >= 4) {
            bgColor = 0;
        }
        bgColor += 1;
    }
    return newPosts;
  },

  getColorNumber: function () {
    return Math.floor((Math.random() * 10)) % 4 + 1;
	},

	originalPostLink: function (post, createdAtSection) {
    var postLink
    if (post.source === 'twitter') {
        postLink = 'https://twitter.com/' + post.screen_name + '/' + 'status/' + post.post_id;
    }
    if (post.source === 'instagram') {
        postLink = 'https://instagram.com/' + 'p/' + post.post_id;
    }

    return "<a href='" + postLink + "' target='_blank'>" + createdAtSection + "</a>";
  }
}
