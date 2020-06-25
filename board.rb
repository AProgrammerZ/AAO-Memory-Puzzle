require_relative "./card.rb"

class Board    
    attr_reader :grid

    def initialize
        @grid = Array.new(4) { [] }
        @guessed_pos = nil
    end

    def populate   
        b_a = make_big_array
        i = 0
        @grid.each do |row|
            while row.length < 4
                card = b_a[i]
                row << card
                i += 1
            end
        end
    end

    def make_big_array
        big_array = []
        until big_array.uniq.length == 16
            random_letter = ("a".."z").to_a.sample
            new_card_a = Card.new(random_letter)
            second_new_card = Card.new(random_letter)
            big_array.push(new_card_a, second_new_card)
        end
        big_array.uniq.shuffle!
    end

    def render
        # horizontal 
        print "  "
        print "0"
        print " "
        print "1"
        print " "
        print "2"
        print " "
        print "3"
        puts        
        i = 0
        @grid.each do |row|
            print i.to_s + " " # vertical
            i += 1            
            row.each do |instance|                 
                if instance.face_up
                    print instance.value
                else
                    print " "
                end
                print " "
            end
            puts
        end
    end

    def won?
        @grid.each do |row|
            return false unless row.all? { |instance| instance.face_up }
        end        
    end

    def reveal(guessed_pos)
        row, col = guessed_pos
        @grid[row][col].reveal
        @grid[row][col].value
    end

    def hide(pos)
        row, col = pos
        @grid[row][col].hide
    end
end