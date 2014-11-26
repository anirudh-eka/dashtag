describe('renderPostHelper', function() {
	var dateHelper = dashtag.dateHelper();
	var renderPostHelper = dashtag.renderPostHelper({dateHelper : dateHelper});

	it("should create post content from json", function() {
		var testPostModels = getJSONFixture('postfixture.json')

    var testPostViewModels = renderPostHelper.createPostContent(testPostModels);

		expect(testPostViewModels[0]).toHaveClass('post-container item');
		});
});