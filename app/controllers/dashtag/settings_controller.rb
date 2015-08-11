require_dependency "dashtag/application_controller"

module Dashtag
  class SettingsController < ApplicationController
    before_action :redirect_to_user_registration_when_dashtag_page_has_no_owner
    
    def edit
      if user_logged_in?
        @settings = Settings.load_settings
      else
        flash[:danger] = "You must be logged in to change your Dashtag's settings."
        redirect_to login_path
      end
    end

    def update
      if user_logged_in?
      	@settings = Settings.new(settings_params)
  		  if @settings.valid?
          @settings.store
  		    flash[:success] = "Succesfully Updated!"
  		    redirect_to settings_edit_path
  		  else
  		    render :action => 'edit'
  		  end
      else
        flash[:danger] = "You must be logged in to change your Dashtag's settings."
        redirect_to login_path
      end
    end

    private

    def settings_params
      params.require(:settings).permit(:hashtags, :twitter_users, 
        :instagram_users, :instagram_user_ids, :header_title, 
        :api_rate, :db_row_limit, :disable_retweets,:header_link,
        :twitter_consumer_key,:twitter_consumer_secret,:instagram_client_id,
        :censored_words,:censored_users,:font_family,:header_color,:background_color,
        :post_color_1,:post_color_2,:post_color_3,:post_color_4)
    end
  end
end
