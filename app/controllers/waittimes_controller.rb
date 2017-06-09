class WaittimesController < ApplicationController

  def update
    puts "============================"
    puts waittime_params[:id]
    puts "============================"
    waittime = Waittime.find(waittime_params[:id])
    waittime.update_attribute(:seated, true)
  end

  def waittime_params
    params.require(:waittime).permit(:id)
  end
end