require_dependency "dashtag/application_controller"

module Dashtag
  class UsersController < ApplicationController
    def new
    	@user = User.new
    end
    def create
      @user = User.new(user_params)

      if @user.save
        
        redirect_to setting_edit_path
      else
        render 'new'
      end
    end

    private

    def user_params
      params.require(:user).permit(:username, :email, :password,
                                   :password_confirmation)
    end
  end
end
