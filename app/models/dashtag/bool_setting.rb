module Dashtag
	class BoolSetting

    def dehydrate
      @bool.to_s
    end
  
    def self.parse(val)
      val.nil? ? nil : BoolSetting.new(convert_to_bool(val))
    end

    def self.hydrate(string)
      new(convert_to_bool(string))
    end

    def to_ui_format
      @bool
    end

    def ==(other)
      return other == @bool if other.class == BoolSetting
      @bool == other
    end

    private

    def initialize(bool)
      @bool = bool
    end

    def self.convert_to_bool(val)
      ActiveRecord::Type::Boolean.new.type_cast_from_database(val)
    end
	end
end