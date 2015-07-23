require 'spec_helper'

module Dashtag
  describe SessionsController do
    before(:each) {allow(User).to receive(:owner_exists?) {true}}
  	routes { Dashtag::Engine.routes }
    describe "GET 'new'" do
		  context "when user is logged in" do
        before(:each) {session[:user_id] = 1}
        it "redirects user to settings page and send flash message explaining user is already logged in" do
          get :new, :format => :html
          expect(response).to redirect_to(setting_edit_path)
          expect(flash[:notice]).to eq("You are already logged in.")
        end
      end
      context "when user is not logged in" do
        before(:each) {session[:user_id] = nil}
        it "returns http success" do
          get :new, :format => :html
          expect(response).to be_success
        end

        context "when dashtag page has no owner" do
          before(:each) {allow(User).to receive(:owner_exists?) {false}}
          it "redirects user to create account page" do
            get :new, :format => :html
            expect(response).to redirect_to(users_new_path)
            expect(flash[:notice]).to eq("Welcome to your Dashtag page! To set it up first you need to register below.")
          end
        end
      end
    end

    describe "POST 'create'" do
      context "when user is logged in" do
        before(:each) {session[:user_id] = 1}
        it "redirects user to settings page and send flash message explaining user is already logged in" do
          get :create, :format => :html
          expect(response).to redirect_to(setting_edit_path)
          expect(flash[:notice]).to eq("You are already logged in.")
        end
      end

    end
  end
end
