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

		postContainer.addClass("post-color-" + bgColor);

		var createdAtSection = "<i class='fa fa-2x fa-" + post.source + "'></i><span class='time-of-post'>"
				+ formattedDate + "</span>";

		postContainer.append("<section class='post-created-at'>" + this.originalPostLink(post, createdAtSection) + "</section>");
		return postContainer;
	},

	createPostContent: function(postsArr) {
    var newPosts = [];
    var self = this;
    $.each(postsArr, function(index, postModel){
      var postViewModel = renderPostHelper.renderPost(postModel, self.getColorNumber(index));
      newPosts.unshift(postViewModel);
    });
    return newPosts;
  },

  getColorNumber: function (index) {
    return index % 4 + 1;
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
