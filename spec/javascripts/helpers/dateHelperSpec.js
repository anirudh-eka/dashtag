describe('dateHelper', function() {
	var dateHelper = dashtag.dateHelper();

	// TODO : first test may not be needed since functionality being tested by
	// "should replace initially loaded timestamps"
	it("should format date to local timezone", function() {
		var timestampDate = new Date("2014", 10, "25", "20", "30", "34");

		var formattedDate = dateHelper.formatDateToLocalTimezone(timestampDate);

		expect(formattedDate).toContain("Tue Nov 25 8:30:34 PM");
	});

	it("should replace initially loaded timestamps", function() {
    var timeOfPost = "<span class='time-of-post'> 2014-11-26 16:10:15 UTC </span>"
    var $jQueryObject = $($.parseHTML(timeOfPost));

    dateHelper.replaceInitiallyLoadedTimestamps($jQueryObject);

    expect($jQueryObject.text()).toContain("Wed Nov 26 4:10:15 PM")
	});

});