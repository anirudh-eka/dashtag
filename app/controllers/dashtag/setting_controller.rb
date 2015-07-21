require_dependency "dashtag/application_controller"

module Dashtag
  class SettingController < ApplicationController
    def edit
    	@settings = Settings.load_settings
    end

    def update
    	@settings = Settings.new(params[:settings])
		  if @settings.valid?
        @settings.store
		    flash[:notice] = "Succesfully Updated!"
		    redirect_to root_url
		  else
		    render :action => 'edit'
		  end
    end
  end
end
