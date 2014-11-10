var applicationController = {
  setupRenderPost: function() {
    var self = this;

    var newPostModels = [];
    var active = false;

    $(ajaxService).on("new-posts", function(e, rawPostData){

      $.each(rawPostData, function(index, rawPost){
        newPostModels.push(self.createPost(rawPost));
      });
        renderPostsForTop();
    })

    $(window).scroll(function() {
        renderPostsForTop();
    });

    function renderPostsForTop() {
      if(!active) {
        if($(window).scrollTop() === 0 && newPostModels.length != 0) {
          active = true;
          var newPostViewModels = renderPostHelper.createPostContent(newPostModels);
          $('#posts-list').prepend(newPostViewModels);
          masonryService.layOutMasonry();
          console.log(newPostModels);
          newPostModels = [];
          active = false;
        }
      }
    }
  },

  setupScroll: function () {
    $('#up').on('click', function(e){
      e.preventDefault();
      var target= $('#hashtag-anchor');
      $('html, body').stop().animate({
          scrollTop: target.offset().top
      }, 750);
    });
  },

  createPost: function(rawPost) {
    return new Post(rawPost.id, rawPost.text, rawPost.media_url, rawPost.screen_name, rawPost.profile_image_url, rawPost.source, rawPost.formatted_time_of_post)
  },

  setupLoadOlderPosts: function() {
    var self = this;
    $("#load-posts-btn").on("click", function(){
      $("#loading").empty()
      $("#loading").append("<i class='fa fa-spinner faa-spin animated'></i>")
      ajaxService.getNextPosts();
      $(ajaxService).on("next-posts", function(e, data){
        $("#loading").empty();
        var newPosts = renderPostHelper.createPostContent(data);
        $('#posts-list').append(newPosts);
        masonryService.layOutMasonry();
      });

      $(ajaxService).on("next-posts:notmodified", function(){
        $("#loading").empty();
        $("#load-posts-btn").text("There are no more posts!");
      });

    });
  }
}
