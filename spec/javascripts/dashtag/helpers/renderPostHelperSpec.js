describe('renderPostHelper', function() {
	var dateHelper = dashtag.dateHelper();
	var renderPostHelper = dashtag.renderPostHelper({dateHelper : dateHelper});

	it("should create post content from json", function() {
		var testPostModels = getJSONFixture('postfixture.json')

    var testPostViewModels = renderPostHelper.createPostContent(testPostModels);

		expect(testPostViewModels[0]).toHaveClass('post-container item');
		expect(testPostViewModels[1]).toHaveClass('post-container item');

		expect(testPostViewModels[0].find('.post-username')).toContainText("sydneyreuille");
		expect(testPostViewModels[1].find('.post-username')).toContainText("noavisar");

		expect(testPostViewModels[0].find('.post-text')).toContainText("Lunch time with the team #dance #reunited #power");
		expect(testPostViewModels[1].find('.post-text')).toContainText("#Dance #Movement #Life");

		expect(testPostViewModels[0]).toHaveClass('post-color-1');
		expect(testPostViewModels[1]).toHaveClass('post-color-2');

		expect(testPostViewModels[0].find('.post-created-at')).toContainHtml('<a href="https://instagram.com/p/v3-8inO00j" target="_blank"><i class="fa fa-2x fa-instagram"></i><span class="time-of-post">Wed Nov 26 1:30:48 PM</span></a>')
		expect(testPostViewModels[1].find('.post-created-at')).toContainHtml('<a href="https://instagram.com/p/v3-8KMDAPR" target="_blank"><i class="fa fa-2x fa-instagram"></i><span class="time-of-post">Wed Nov 26 1:30:45 PM</span></a>')

	});
});
