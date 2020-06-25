class HumanPlayer
    def prompt
        puts "Please enter the position of the card you'd like to flip (like so: 2,3):"            
    end

    def get_input
        guess = gets.chomp
        coordinates = guess.split(",").map(&:to_i)
    end

    
    # NB: The game shouldn't have to know whether a human or computer is playing.
    # Instead, it should use duck typing.
    # This may involve writing some "dummy" methods on the HumanPlayer class.
    # That's ok.

    def receive_revealed_card(pos, card_val)
        return true
    end

    def receive_match(pos_1, pos_2)
        return true
        # WHAT IS THE POINT OF THIS METHOD?
    end 
end 