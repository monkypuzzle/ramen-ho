class WelcomeController < ApplicationController

  def index
    if !admin_signed_in?
      redirect_to "/admins/sign_in"
    end
  end
end
