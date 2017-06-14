class AddImagePathToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :image_path, :string
  end
end
