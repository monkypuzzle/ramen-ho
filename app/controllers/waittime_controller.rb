class WaittimeController < ApplicationController

  def update
    seated_waittime = Waittime.where(seated: false).order(:created_at)
    seated_waittime.update(:seated, true)
  end
end