desc "This task is called by the Heroku scheduler add-on"
task :update_feed => :environment do
  Rails.application.eager_load!
  puts "Updating feed..."
  puts "*" * 80
  TweetService.get_tweets_by_hashtag "NAAwayDay"
  # NewsFeed.update
  puts "done."
end
