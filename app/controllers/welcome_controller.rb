class WelcomeController < ApplicationController

  def index
    redirect_to "/admins/sign_in" if !admin_signed_in?
    # @restaurant = Restaurant.find(current_admin.restaurant.id)
    # @waittimes = Waittime.where(restaurant_id: @restaurant.id, seated: false)
  end
end
