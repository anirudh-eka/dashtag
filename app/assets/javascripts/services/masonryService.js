var dashtag = dashtag || {}

dashtag.masonryService = function(){
  var that = {};

  that.layOutMasonry =  function(){
  	var masonryList = document.querySelector('#posts-list');
    var msnry = new Masonry(masonryList);
    imagesLoaded(masonryList, function () {
        msnry.layout();
    });
  }
  return that;
}
