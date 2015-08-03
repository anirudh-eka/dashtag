module Dashtag
  class ApplicationController < ActionController::Base
  	  include SessionsHelper

    private
    
    def redirect_to_user_registration_when_dashtag_page_has_no_owner
      unless User.owner_exists?
        flash[:notice] = "Welcome to your Dashtag page! To set it up first you need to register below."
        redirect_to users_new_path
      end
    end

  	def redirect_to_edit_settings_if_user_is_already_logged_in
      if user_logged_in?
        flash[:notice] = "You are already logged in."
        redirect_to settings_edit_path
      end
    end
  end
end
