require 'spec_helper'

module Dashtag
  describe SettingController do

    describe "GET 'edit'" do
      it "returns http success" do
        get 'edit'
        response.should be_success
      end
    end

  end
end
