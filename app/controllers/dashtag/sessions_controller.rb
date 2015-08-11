require_dependency "dashtag/application_controller"

module Dashtag
  class SessionsController < ApplicationController
    before_action :redirect_to_edit_settings_if_user_is_already_logged_in, 
                      only: [:new, :create]

    before_action :redirect_to_user_registration_when_dashtag_page_has_no_owner

    def new
    end

    def create
    	user = User.find_by(email: params[:session][:email].downcase)
	    if user && user.authenticate(params[:session][:password])
        log_in user
        redirect_to settings_edit_path
	    else
	      flash.now[:danger] = 'Invalid email/password combination'
	      render 'new'
	    end
    end

    def destroy
      log_out
      redirect_to root_url
    end
  end
end
