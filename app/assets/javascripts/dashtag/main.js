"use strict";

var dashtag = dashtag || {}

dashtag.main = function() {
  var that = {};
	var masonryService = dashtag.masonryService();
	var ajaxService = dashtag.ajaxService();
	var applicationController = dashtag.applicationController({ajaxService : ajaxService, masonryService: masonryService});

	that.run = function(){
	  masonryService.layOutMasonry();

	  applicationController.setupScroll();

	  ajaxService.setup();

	  applicationController.setupRenderPost();

	  applicationController.setupLoadOlderPosts();
		}
  return that;
}


