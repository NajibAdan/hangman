class Player
    attr_accessor :name, :guess_word
    def initialize
        puts "Enter your name"
        @name = gets.chomp.downcase
        @guess_word
    end
    def guess
        puts 'Guess a letter in the mystery word'
        @guess_word = gets.chomp.downcase.strip
        if @guess_word.match(/[^a-z]/)
            puts 'ONLY LETTERS PLEASE'
            guess
        else
            @guess_word = @guess_word
        end
    end
end
