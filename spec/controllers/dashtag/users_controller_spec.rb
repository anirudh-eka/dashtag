require 'spec_helper'

module Dashtag
  describe UsersController do
  	routes { Dashtag::Engine.routes }
    describe "GET 'new'" do
      context "when user is logged in" do
        before(:each) {session[:user_id] = 1}
        it "redirects user to settings page and send flash message explaining user is already logged in" do
          get :new, :format => :html
          expect(response).to redirect_to(settings_edit_path)
          expect(flash[:notice]).to eq("You are already logged in.")
        end
      end
      context "when user is not logged in" do
        before(:each) {session[:user_id] = nil}
        it "returns http success" do
          get :new, :format => :html
          expect(response).to be_success
        end

        context "when there is already one user in the system" do
          before(:each) {allow(User).to receive(:owner_exists?) {true}}
          it "redirects user to login page with message explaining that owner already exists" do
            get :new, :format => :html
            expect(response).to redirect_to(login_path)
            expect(flash[:notice]).to eq("An owner is already registered for this Dashtag page. Please login to edit the settings.")
          end
        end
      end
    end

    describe "POST 'create'" do
      context "when user is logged in" do
        before(:each) {session[:user_id] = 1}
        it "redirects user to settings page and send flash message explaining user is already logged in" do
          get :create, :format => :html
          expect(response).to redirect_to(settings_edit_path)
          expect(flash[:notice]).to eq("You are already logged in.")
        end
      end

      context "when user is not logged in" do
        before(:each) {session[:user_id] = nil}
        context "when there is already one user in the system" do
          before(:each) {allow(User).to receive(:owner_exists?) {true}}
          it "redirects user to login page with message explaining that owner already exists" do
            get :create, :format => :html
            expect(response).to redirect_to(login_path)
            expect(flash[:notice]).to eq("An owner is already registered for this Dashtag page. Please login to edit the settings.")
          end
        end

        it "should register user and log them in" do
          allow(User.new)
          get :create, :format => :html, user: { username: "dashy", email: "dashy@tag.co", password: "password", password_confirmation: "password"}
          expect(response).to redirect_to(settings_edit_path)
          expect(session[:user_id]).to_not be_nil
          expect(flash[:success]).to eq("Great, you're registered! Now it's time to setup your Dashtag page. Below are the settings you can edit. If you ever want to change the settings just click on the gear icon in the top right!")
        end
      end
    end
  end
end
