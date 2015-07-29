require 'spec_helper'

module Dashtag
  describe SettingController do
    before(:each) {allow(User).to receive(:owner_exists?) {true}}
  	routes { Dashtag::Engine.routes }
    describe "GET 'edit'" do
      context "when user is not logged in" do
        before(:each) {session[:user_id] = nil}
        it "redirects user to login page and send flash message explaining user must be logged in" do
          get :edit, :format => :html
          expect(response).to redirect_to(login_path)
          expect(flash[:danger]).to eq("You must be logged in to change your Dashtag's settings.")
        end
      end
      context "when user is logged in" do
        before(:each) {session[:user_id] = 1}
        it "returns http success" do
          get :edit, :format => :html
          expect(response).to be_success
        end
      end
      context "when dashtag page has no owner" do
        before(:each) {allow(User).to receive(:owner_exists?) {false}}
        it "redirects user to create account page" do
          get :edit, :format => :html
          expect(response).to redirect_to(users_new_path)
          expect(flash[:notice]).to eq("Welcome to your Dashtag page! To set it up first you need to register below.")
        end
      end
    end

    describe "POST 'update'" do
      context "when user is not logged in" do
        before(:each) {session[:user_id] = nil}
        it "redirects user to login page and send flash message explaining user must be logged in" do
          post :update, :format => :html
          expect(response).to redirect_to(login_path)
          expect(flash[:danger]).to eq("You must be logged in to change your Dashtag's settings.")
        end
      end
      context "when user is logged in" do
        before(:each) do
          setting = double("setting", valid?: true, store: true)
          allow(Settings).to receive(:new) {setting}
          session[:user_id] = 1
        end
        it "redirects to setting edit path" do
          post :update, :format => :html, settings: {hashtags: "#hi"}
          expect(response).to redirect_to setting_edit_path
          expect(flash[:success]).to eq("Succesfully Updated!")
        end
      end
    end

  end
end