class AddLatitudeLongitudeToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :latitude, :double
    add_column :properties, :longitude, :double
  end
end
