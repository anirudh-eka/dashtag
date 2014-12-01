describe('Post', function() {
	var rawPost = getJSONFixture('postfixture.json')[0]

	it("should create post object from hash", function() {
		var post = new Post(rawPost)

		for (var key in post) {
			expect(post[key]).toBe(rawPost[key])
		}
	});

});
