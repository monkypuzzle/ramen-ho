require 'waitcalc'

class Waittime < ActiveRecord::Base
  belongs_to :restaurant


  scope :parties_before, ->(current_restaurant) { where(restaurant_id: current_restaurant, seated: false)}

  def estimated_waittime
    num_parties_before = Waittime.where(seated: false).where(restaurant_id: self.restaurant.id).where("created_at < ?", self.created_at).length
    Waitcalc.find_waittime(num_parties_before)
  end

end
