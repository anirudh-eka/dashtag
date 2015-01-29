"use strict";

function Post(data) {
	data = data || {};
	self = {};
	var fields = [
		'id',
		'text',
		'media_url',
		'screen_name',
		'profile_image_url',
		'source',
		'post_id',
		'time_of_post'
	];
	fields.forEach(function(field) {
		self[field] = data[field];
	});
	return self;
}
