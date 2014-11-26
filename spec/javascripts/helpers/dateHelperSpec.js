describe('dateHelper', function() {
	var dateHelper = dashtag.dateHelper();

	it("should format date to local timezone", function() {
		var timestampDate = new Date("2014", 10, "25", "20", "30", "34");

		var formattedDate = dateHelper.formatDateToLocalTimezone(timestampDate);

		expect(formattedDate).toEqual("Tue Nov 25 8:30:34 PM");
	});

	// it("replace initially loaded timestamps", function() {
 //    var timeOfPost = '<span class=​"time-of-post">​ 2014-11-25 21:27:04 UTC ​</span>​'
 //    var $jQueryObject = $($.parseHTML(timeOfPost));
 //    console.log($jQueryObject);

 //    var expected = dateHelper.replaceInitiallyLoadedTimestamps($jQueryObject);

	// });
});