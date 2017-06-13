class WelcomeController < ApplicationController

  def index
    @waittime = Waittime.new
#######commented out line 6 bc it was causing error when opening page########
    #redirect_to "/admins/sign_in" if !admin_signed_in?
    # @restaurant = Restaurant.find(current_admin.restaurant.id)
    # @waittimes = Waittime.where(restaurant_id: @restaurant.id, seated: false)
    if !admin_signed_in?
      redirect_to "/admins/sign_in"
      @restaurant = Restaurant.new
    else
      @restaurant = Restaurant.find(current_admin.restaurant.id)
    end
    @waittimes = Waittime.where(restaurant_id: @restaurant.id, seated: false).order(:id)
    @table_ready_waittimes = Waittime.where(restaurant_id: @restaurant.id, seated: false, table_ready: true)
  end

  def mobile
    @restaurants = Restaurant.all
  end
end
