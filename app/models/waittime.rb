require 'waitcalc'

class Waittime < ActiveRecord::Base
  belongs_to :restaurant

  validates :customer, format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/, message: "cannot have numbers or symbols"}

  scope :parties_before, ->(current_restaurant) { where(restaurant_id: current_restaurant, seated: false)}

  scope :most_recent_waittime, ->(current_restaurant) { where(restaurant_id: current_restaurant, seated: false).order(:created_at).last }

  def estimated_waittime
    # puts '============================='
    # puts 'HEY'
    # puts '============================='
    num_parties_before = Waittime.where(seated: false).where(restaurant_id: self.restaurant.id).where("created_at < ?", self.created_at).length
    Waitcalc.find_waittime(num_parties_before)
  end

end
