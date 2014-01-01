class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.integer :number_of_bedrooms
      t.integer :number_of_bathrooms
      t.integer :rent_a_week
      t.string :address
      t.string :streetName
      t.string :agentName
      t.string :agentPhoneNo
      t.string :imageUrl
      t.string :thumbnailUrl
      t.text :shortDescription
      t.string :detailsUrl

      t.timestamps
    end
  end
end
