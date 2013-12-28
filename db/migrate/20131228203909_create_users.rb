class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :deviceToken
      t.string :deviceType

      t.timestamps
    end
  end
end
