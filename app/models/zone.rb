class Zone < ActiveRecord::Base

	has_many :user_watch_zone

	has_many :watchers, :class_name => "User" , :through => :user_watch_zone , :source => :user

	has_many :properties, -> { order('created_at DESC').limit(10)} ,
			dependent: :destroy

	require 'open-uri'

	def processProperties

		#time difference in minutes. won't que updates unless this is
		#higher than 3600

		time_difference = Time.now - self.updated_at
		if ( Time.now - self.created_at < 5 )
			# forcing to update newly created zones
			time_difference = 3601
		end
		puts time_difference
		if time_difference < 3600
			return
		end

		self.touch

		#url = "http://api.zoopla.co.uk/api/v1/property_listings.json?postcode=#{self.postcode}&api_key=4axhtay3kpj7y4397k2nb6a4&listing_status=rent&page_size=100&order_by=age"
		url = "http://localhost/date.json"
		response = open(url).read

		jsonObject = JSON.parse ( response )

		listings = jsonObject["listing"]

		user_notifications = Array.new(self.user_watch_zone.count,0)

		listings.each do |current_listing|
			listing = current_listing
			currentProperty = Property.where(detailsUrl: listing["details_url"]).first_or_initialize(
					streetName: listing["street_name"],
					number_of_bedrooms: listing["num_bedrooms"].to_i,
					number_of_bathrooms:  listing["num_bathrooms"].to_i,
					address: listing["displayable_address"],
					agentName: listing["agent_name"],
					agentPhoneNo: listing["agent_phone"],
					imageUrl: listing["image_url"],
					thumbnailUrl: listing["thumbnail_url"],
					shortDescription: listing["short_description"],
					description: listing["description"],
					detailsUrl: listing["details_url"],
					latitude: listing["latitude"],
					longitude: listing["longitude"],
					rent_a_week: listing["rental_prices"]["per_week"],
					zone_id: self.id
				)
			currentProperty.save!

			self.user_watch_zone.each_with_index do |watchZone, index|

				user = watchZone.user
				ok = true
				if ( watchZone.min_rent != 0 && watchZone.max_rent != 0 )
					#we need to take rent into account
					if ! ( watchZone.min_rent < currentProperty.rent_a_week &&
							currentProperty.rent_a_week < watchZone.max_rent )
						ok = false
					end
				end

				if ( watchZone.min_bedrooms != 0 && watchZone.max_bedrooms != 0 )
					#we need to take the number of bedrooms into account

					#first make sure that this property has a number of bedrooms
					if ( currentProperty.number_of_bedrooms != 0 )
						if ! ( watchZone.min_bedrooms < currentProperty.number_of_bedrooms &&
								currentProperty.number_of_bedrooms < watchZone.max_bedrooms )
							ok = false
						end
					end
				end

				#satisfied both properties, then send notification
				if ( ok )
					user_notifications[index] = user_notifications[index] + 1
				end
			end
		end

		puts user_notifications.inspect

		self.user_watch_zone.each_with_index do |watchZone,index|
			if ( ! user_notifications[index].nil?)
				watchZone.user.send_notification( "new #{user_notifications[index]} properties" )
			end
		end

	end
	handle_asynchronously :processProperties


end
