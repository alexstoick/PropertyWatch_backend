namespace :jobs do
	desc "Calls processProperties on all of the zones"
	task generate: :environment do

		zones = Zone.all

		zones.each do |zone|
			puts "Updating for zone # #{zone.id}"
			zone.processProperties
		end
	end

end
