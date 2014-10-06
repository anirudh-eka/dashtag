desc "This task can be called by the Heroku scheduler add-on"
namespace :db do
	task :clear_half_db => :environment do
	  t = Time.now
	  puts "Clearing 50% of old posts..."
	  old_posts = Post.order(time_of_post: :asc).first(Post.all.count/2)
	  old_posts.each(&:destroy)
	  puts "done in #{Time.now - t} seconds."
	end
end

