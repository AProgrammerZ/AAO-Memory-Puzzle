class Card
    attr_reader :value, :face_up

    def initialize(value)
        @value = value
        @face_up = true
    end

    def display_info
        return @value if @face_up == true
    end

    def hide
        @face_up = false
    end

    def reveal 
        @face_up = true
    end

    def to_s
        # I dont know what this is supposed to do...
    end

    def ==(other_card)
        self.value == other_card.value
    end    
end