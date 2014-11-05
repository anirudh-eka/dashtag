var masonryService = {
	layOutMasonry: function () {
	    var masonryList = document.querySelector('#posts-list');
	    var msnry = new Masonry(masonryList);
	    imagesLoaded(masonryList, function () {
	        msnry.layout();
	    });
	}
}

