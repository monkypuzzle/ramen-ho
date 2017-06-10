class AddRestaurantIdToAdmins < ActiveRecord::Migration[5.0]
  def change
    add_column :admins, :restaurant_id, :integer
  end
end
