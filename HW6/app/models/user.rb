class User < ActiveRecord::Base

	has_many :topics
	has_many :comments

end
