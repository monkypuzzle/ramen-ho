class Restaurant < ActiveRecord::Base
  has_many :waittimes
  has_one :admin
end
