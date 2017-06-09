class CreateWaittimes < ActiveRecord::Migration
  def change
    create_table :waittimes do |t|
      t.integer :party_size
      t.boolean :seated

      t.timestamps null: false
    end
  end
end
