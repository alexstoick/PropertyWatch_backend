class AddZoneIdToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :zone_id, :integer
  end
end
