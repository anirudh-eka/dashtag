require 'spec_helper'

module Dashtag
  describe BoolSetting do
    it "should parse string into BoolSetting" do
    	["0", false, "false"].each do |false_values| 
        boolean = BoolSetting.parse(false_values)
        expect(boolean).to eq(BoolSetting.new(false))
      end
      ["1", true, "true"].each do |true_values| 
        boolean = BoolSetting.parse(true_values)
        expect(boolean).to eq(BoolSetting.new(true))
      end
    end

    it "should parse nil into nil" do
      boolean = BoolSetting.parse(nil)
      expect(boolean).to eq(nil)
      expect(boolean.class).to eq(NilClass)
    end

    it "should dehydrate itself" do
      boolean = BoolSetting.parse("0")
      expect( boolean.dehydrate ).to eq("false")
    end

    it "should hydrate a BoolSetting" do
      boolean = BoolSetting.parse("0")
      expect( BoolSetting.hydrate(boolean.dehydrate)).to eq(BoolSetting.parse("false"))
    end

    it "should convert to ui representation" do
      boolean = BoolSetting.parse("0")
      expect(boolean.to_ui_format).to eq(false)
    end
  end
end
