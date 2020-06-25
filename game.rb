require_relative "./board.rb"
require_relative "./human_player.rb"
require_relative "./computer_player.rb"

class Game    
    def initialize
        @board = Board.new
        @previous_guess = nil
        @player_type = get_player_type
        if @player_type == "human"
            @player = HumanPlayer.new
        else
            @player = ComputerPlayer.new
        end
    end

    def get_player_type
        puts "Please enter the type of player ('human' or 'computer'):"
        response = gets.chomp
        raise "please enter a valid type of player" unless response == "human" || response == "computer"
        response
    end

    def play
        @board.populate
        self.preview
        
        over = false
        until over do
            system("clear")
            @board.render
            @player.prompt
            sleep(0.3) if @player_type == "computer"
            coordinates_arr = @player.get_input
            print coordinates_arr if @player_type == "computer"    
            sleep(0.3) if @player_type == "computer"        
            make_guess(coordinates_arr)
            row, col = coordinates_arr
            @player.receive_revealed_card(coordinates_arr, @board.grid[row][col].value)
            over = true if @board.won?
        end
        puts "You win!"
    end

    def preview
        if @player_type == "human"
            @board.render
            sleep(3)
        end
        @board.grid.each do |row|
            row.map(&:hide)
        end
    end

    def make_guess(pos)
        if @previous_guess == nil
            @board.reveal(pos)
            @previous_guess = pos
        else
            @board.reveal(pos)
            row, col = pos
            row_p, col_p = @previous_guess
            if @board.grid[row][col] == @board.grid[row_p][col_p]
                @player.receive_match(pos, @previous_guess)
                system("clear")
                @board.render
                puts "It's a match!" 
                sleep(1)
            else
                system("clear")
                @board.render
                puts "Try again."
                sleep(1)
                @board.hide(pos)
                @board.hide(@previous_guess) 
            end
            @previous_guess = nil
        end
    end
end

game = Game.new
game.play    