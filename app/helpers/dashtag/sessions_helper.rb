module Dashtag
  module SessionsHelper

    # Logs in the given user.
    def log_in(user)
      session[:user_id] = user.id
    end

    def user_logged_in?
      session[:user_id]
    end
  end
end