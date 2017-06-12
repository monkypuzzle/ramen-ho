class Waittime < ActiveRecord::Base
  belongs_to :restaurant

  validates :customer, format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/, message: "cannot have numbers or symbols"}
end
