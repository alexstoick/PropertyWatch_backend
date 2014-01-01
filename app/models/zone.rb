class Zone < ActiveRecord::Base

	has_many :user_watch_zone

	has_many :watchers, :class_name => "User" , :through => :user_watch_zone , :source => :user

	has_many :properties,
			dependent: :destroy

	require 'open-uri'

	def processProperties

		#time difference in minutes. won't que updates unless this is
		#higher than 60

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

		url = "http://api.zoopla.co.uk/api/v1/property_listings.json?postcode=#{self.postcode}&api_key=4axhtay3kpj7y4397k2nb6a4&listing_status=rent&page_size=100&response_type=json"
		response = open(url).read

		jsonObject = JSON.parse ( response )

		listings = jsonObject["listing"]

		listings.each do |current_listing|
			listing = current_listing
			currentProperty = Property.new(
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
				latitude: listing["latitude"], # add to model
				longitude: listing["longitude"], # add to model
				rent_a_week: listing["rental_prices"]["per_week"],
				zone_id: self.id
			)

			currentProperty.save!
		end
	end
	handle_asynchronously :processProperties


end
