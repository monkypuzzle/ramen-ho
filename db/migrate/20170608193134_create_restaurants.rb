class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.integer :number_of_seats
      t.integer :crowdsourced_waittime
      t.jsonb :operating_hours, null: false
      t.string :address, null: false
      t.string :phone, null: false

      t.timestamps null: false
    end
  end
end
