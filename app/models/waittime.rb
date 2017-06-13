require 'waitcalc'

class Waittime < ActiveRecord::Base
  belongs_to :restaurant

  validates :customer, format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/, message: "name cannot have numbers or symbols"}
  validates :party_size, format: { with: /\A\d{1,2}\z/, message: "is invalid. " }
  validates :phone, format: { with: /\d{3}\d{3}\d{4}/, message: "is invalid. Please enter numbers only."}

  scope :parties_before, ->(current_restaurant) { where(restaurant_id: current_restaurant, seated: false)}

  def estimated_waittime
    # puts '============================='
    # puts 'HEY'
    # puts '============================='
    num_parties_before = Waittime.where(seated: false).where(restaurant_id: self.restaurant.id).where("created_at < ?", self.created_at).length
    Waitcalc.find_waittime(num_parties_before)
  end

end
