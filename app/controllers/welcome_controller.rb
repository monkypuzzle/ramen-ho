class WelcomeController < ApplicationController

  def index
    if !admin_signed_in?
      redirect_to "/admins/sign_in"
      @restaurant = Restaurant.new
    else
      @restaurant = Restaurant.find(current_admin.restaurant.id)
    end
    @waittimes = Waittime.where(restaurant_id: @restaurant.id, seated: false)
  end
end
