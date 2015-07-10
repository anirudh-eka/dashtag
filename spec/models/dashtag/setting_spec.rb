require 'spec_helper'

module Dashtag
  describe Setting do
    it { should validate_presence_of(:name) }
  end
end