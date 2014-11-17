// function Post(data) {
// 	data = data || {};
// 	self = {};
// 	fields = [
// 		'id',
// 		'text',
// 		'media_url',
// 		'screen_name',
// 		'profile_image_url',
// 		'source',
// 		'time_of_post'
// 	];
// 	fields.forEach(function(field) {
// 		self[field] = data[field];
// 	});
// 	return self;
// }


function Post(id, text, media_url, screen_name, profile_image_url, source, time_of_post) {
  this.id = id;
  this.text = text;
  this.media_url = media_url;
  this.screen_name = screen_name;
  this.profile_image_url = profile_image_url;
  this.source = source;
  this.timeOfPost = time_of_post;
}
