class AddDescriptionToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :description, :string
  end
end
