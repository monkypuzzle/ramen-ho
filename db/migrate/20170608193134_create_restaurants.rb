class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.integer :number_of_seats
      t.integer :crowdsourced_waittime
      t.jsonb :operating_hours
      t.string :address
      t.string :phone

      t.timestamps null: false
    end
  end
end
