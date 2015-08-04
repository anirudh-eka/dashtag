require_dependency "dashtag/application_controller"

module Dashtag
  class UsersController < ApplicationController
    before_action :redirect_to_edit_settings_if_user_is_already_logged_in, 
                  only: [:new, :create]
    before_action :redirect_to_login_if_owner_exists, 
                  only: [:new, :create]
    def new 
    	@user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        log_in @user
        flash[:success] = "Great, you're registered! Now it's time to setup your Dashtag page. 
        Below are the settings you can edit. If you ever want to change the settings
        just click on 'settings' on the top left to be brought back to this page."
        redirect_to settings_edit_path
      else
        render 'new'
      end
    end

    private

    def user_params
      params.require(:user).permit(:username, :email, :password,
                                   :password_confirmation)
    end

    def redirect_to_login_if_owner_exists
      if User.owner_exists?
        flash[:notice] = "An owner is already registered for this Dashtag page. Please login to edit the settings."
        redirect_to login_path
      end
    end
  end
end
