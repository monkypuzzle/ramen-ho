class AddMapLinkTableToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :maplink, :string
  end
end
