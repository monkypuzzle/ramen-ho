class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :omniauthable, :recoverable, :trackable
  devise :database_authenticatable, :registerable, :rememberable, :validatable, :timeoutable
end
