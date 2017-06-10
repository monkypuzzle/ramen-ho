class WelcomeController < ApplicationController

  def index
    @waittime = Waittime.new
    redirect_to "/admins/sign_in" if !admin_signed_in?
    # @restaurant = Restaurant.find(current_admin.restaurant.id)
    # @waittimes = Waittime.where(restaurant_id: @restaurant.id, seated: false)
    if !admin_signed_in?
      redirect_to "/admins/sign_in"
      @restaurant = Restaurant.new
    else
      @restaurant = Restaurant.find_or_initialize_by(id: current_admin.restaurant.id)
    end
    @waittimes = Waittime.where(restaurant_id: @restaurant.id, seated: false)
  end

  def mobile
  end
end
