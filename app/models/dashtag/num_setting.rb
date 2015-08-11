module Dashtag
	class NumSetting

		def initialize num
			@number = num
		end

    def dehydrate
      @number.to_s
    end
  
    def self.parse(num)
      num.blank? ? nil : new(Integer(num))
    end

    def self.hydrate(num)
      new(Integer(num))
    end

    def ==(arg)
    	@number == arg
    end

    def to_ui_format
      @number
    end

    def as_int
      @number
    end
	end
end