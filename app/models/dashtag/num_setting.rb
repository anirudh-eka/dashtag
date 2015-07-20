module Dashtag
	class NumSetting

		def initialize num
			@number = num
		end

    def dehydrate
      @number.to_s
    end
  
    def self.parse(num)
      new(Integer(num))
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
	end
end