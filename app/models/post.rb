class Post
	def self.all
    (Tweet.all + Gram.all).sort_by { |post| post.created_at }.reverse!
	end
end