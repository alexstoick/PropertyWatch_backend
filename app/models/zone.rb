class Zone < ActiveRecord::Base

	has_many :user_watch_zone

	has_many :watchers, :class_name => "User" , :through => :user_watch_zone , :source => :user

end
