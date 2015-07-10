module Dashtag
  class Setting < ActiveRecord::Base
  	validates_presence_of :name
  end
end
