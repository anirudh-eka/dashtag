"use strict";

var dashtag = dashtag || {}

dashtag.dateHelper = function() {
  var that = {};

  var parseDateFromUTC = function(date) {
    var timeUnits = date.split(/[-\s:]+/),
      year = timeUnits[0], month = timeUnits[1]-1, day = timeUnits[2],
      hour = timeUnits[3], minutes = timeUnits[4], seconds = timeUnits[5];
    return new Date(year, month, day, hour, minutes, seconds);
  };

  that.formatDateToLocalTimezone = function(timestampDate) {
    var date = timestampDate.toString().substring(0, 11);
    return date.concat(timestampDate.toLocaleTimeString());
  };

  that.replaceInitiallyLoadedTimestamps = function(timestamps) {
    for(var i=0; i < timestamps.length ; i++) {
      var timestampString = $(timestamps[i]).text().trim();
      var timestampDate = parseDateFromUTC(timestampString);
      $(timestamps[i]).text(that.formatDateToLocalTimezone(timestampDate));
    }
  };
  return that;
}

