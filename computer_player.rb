class ComputerPlayer
    def initialize
        @known_cards = Hash.new { |h, k| h[k] = [] }
        @matched_cards = []
        @current_guess = 1
        @f_g_pos = 0
    end
    
    def prompt
        puts "Please enter the position of the card you'd like to flip (like so: 2,3):"            
    end

    def get_input
        if @current_guess == 1
            @f_g_pos = first_guess
            return @f_g_pos
        else
            return second_guess(@f_g_pos)
        end         
    end   

    def first_guess
        @current_guess = 2
        values = @known_cards.values.select { |pos_arrs| pos_arrs.length > 1 }
        if !values.empty?
            suitable = values.find { |pos_arrs| available(pos_arrs).length >= 2 }
            if suitable == nil
                return random_guess
            else
                return available(suitable).first
            end
        else
            return random_guess
        end   
    end

    def second_guess(first_pos)
        @current_guess = 1
        @known_cards.each_value do |pos_arrs|
            if pos_arrs.length > 1 && pos_arrs.include?(first_pos)
                return other_pos(first_pos, pos_arrs)               
            end
        end
        random_guess
    end

    def available(arrs)
        arrs.select { |pos| !@matched_cards.include?(pos) }
    end

    def other_pos(first_pos, pos_arrs)
        if available(pos_arrs).include?(first_pos) && available(pos_arrs).length > 1
            return available(pos_arrs).find { |pos| first_pos != pos }
        else
            return random_guess
        end
    end

    def random_guess
        pos = make_pos
        until check_pos(pos)
            pos = make_pos
        end
        pos
    end

    def receive_revealed_card(pos, card_val)
        @known_cards[card_val] << pos unless @known_cards[card_val].include?(pos)
    end

    def receive_match(pos_1, pos_2)
        @matched_cards.push(pos_1, pos_2)
    end

    def make_pos
        row = (0..3).to_a.sample
        col = (0..3).to_a.sample
        [row,col]
    end

    def check_pos(pos)
        @known_cards.each_value do |pos_arrs|
            pos_arrs.each { |position| return false if pos == position }                            
        end
        true
    end
end