class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :number_of_bedrooms,
      t.string :number_of_bathrooms,
      t.string :rent_a_week,
      t.string :address,
      t.string :street_name,
      t.string :agentName,
      t.string :agentPhoneNo,
      t.string :imageUrl,
      t.string :thumbnailUrl,
      t.string :shortDescription,
      t.string :detailsUrl

      t.timestamps
    end
  end
end
