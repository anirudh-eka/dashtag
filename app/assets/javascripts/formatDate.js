var formatDateToLocalTimezone = function(timestampDate) {
  var date = timestampDate.toString().substring(0, 11);
  return date.concat(timestampDate.toLocaleTimeString());
}

var replaceInitiallyLoadedTimestamps = function() {
  var timestamps = $(".post-created-at");

  for(var i=0; i< timestamps.length-1 ; i++) {
    var timestampString = $(timestamps[i]).text().trim();
    var timestampDate = parseDateFromUTC(timestampString);
    $(timestamps[i]).text(formatDateToLocalTimezone(timestampDate));
  }
}

var parseDateFromUTC = function(date) {
  var timeUnits = date.split(/[-\s:]+/),
    year = timeUnits[0], month = timeUnits[1]-1, date = timeUnits[2],
    hour = timeUnits[3], minutes = timeUnits[4], seconds = timeUnits[5];
  return new Date(year, month, date, hour, minutes, seconds);
}
