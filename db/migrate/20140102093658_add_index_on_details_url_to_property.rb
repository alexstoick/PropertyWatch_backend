class AddIndexOnDetailsUrlToProperty < ActiveRecord::Migration
  def change
  	add_index :properties, :detailsUrl, :unique => true
  end
end
