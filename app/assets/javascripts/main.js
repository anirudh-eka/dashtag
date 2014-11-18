var dashtag = dashtag || {}

dashtag.main = function() {
  var that = {};
	var dateHelper = dashtag.dateHelper();
	var masonryService = dashtag.masonryService();
  var ajaxService = dashtag.ajaxService();
	var renderPostHelper = dashtag.renderPostHelper({dateHelper : dateHelper});
	var applicationController = dashtag.applicationController({
																														renderPostHelper: renderPostHelper,
																														ajaxService : ajaxService,
																														masonryService: masonryService});

 	that.run = function(){
 		masonryService.layOutMasonry();

	  dateHelper.replaceInitiallyLoadedTimestamps();

	  applicationController.setupScroll();

	  ajaxService.setup();

	  applicationController.setupRenderPost();

	  applicationController.setupLoadOlderPosts();
 	}
  return that;
}


