class AddPropertiesToZoneWatch < ActiveRecord::Migration
  def change
    add_column :user_watch_zones, :min_rent, :integer
    add_column :user_watch_zones, :max_rent, :integer
    add_column :user_watch_zones, :min_bedrooms, :integer
    add_column :user_watch_zones, :max_bedrooms, :integer
  end
end
