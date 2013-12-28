class User < ActiveRecord::Base

	has_many :user_watch_zones

	has_many :zones, :through => :user_watch_zones

end
