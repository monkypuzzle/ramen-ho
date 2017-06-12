class Waittime < ActiveRecord::Base
  belongs_to :restaurant

  scope :parties_before, ->(current_restaurant) { where(restaurant_id: current_restaurant, seated: false)}
end
