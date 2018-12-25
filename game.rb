require 'YAML'
class Game
    attr_accessor :word, :guess, :mystery_word, :misses, :round, :name
    def initialize(name = 'PLAYER 1')
        Dir.mkdir("./saved_games") unless Dir.exists? "./saved_games"
        @mystery_word = ''
        @misses = []
        @guess
        @round = 1
        @word
        @player_name = name
        @directory = './saved_games/'
    end

    def save_game_confirmation
        if @misses.length!= 5
            puts 'Do you want to save your game?'
            response = gets.chomp.downcase
            if response[0] == 'y'
                save_game
            end
        end
    end

    def choose_word
        lines = File.readlines('words.txt')
        @word = lines[rand(lines.length)].downcase.strip
        @mystery_word = @mystery_word.rjust(@word.length,'X')
    end

    def check_letter
        positions = []
        if @misses.include?(@guess) || @mystery_word.include?(@guess)
            positions.push('0')
        else
            positions = (0 ... @word.length).find_all { |i| @word[i,1] == @guess }
        end
        if positions.empty?
            puts 'WRONG LETTER!'
            @misses.push(@guess)
        elsif positions[0] == '0'
            puts 'THE LETTER HAS ALREADY BEEN SHOWN!'
        else
            puts 'CORRECT!'
            positions.each do |i|
                @mystery_word[i] = @guess
            end
        end
        @guess = ''
        rounds
        save_game_confirmation
    end

    def game_over?
        if @misses.length == 5
            puts 'YOU LOST! GAME OVER'
            return true
        elsif !@mystery_word.include?('X')
            puts "YOU WON!"
            return true
        end
    end

    def rounds
        @round += 1
    end

    def save_game
        data = YAML.dump ({
            :player_name => @player_name,
            :mystery_word => @mystery_word,
            :misses => @misses,
            :round => @round,
            :word => @word
        })

        puts "Enter the name of your save file"
        file_name = gets.chomp.split(' ').join('_').to_s
        file_name = './saved_games/' + file_name + '.yaml'
        File.open(file_name,'w'){
            |file| file.puts data
        }
        puts "#{file_name} saved!"
    end

    def load_game_confirmation
        puts "Choose the following saved games!"
        Dir['./saved_games/*'].each_with_index do |file, i|
            puts "#{file}"
        end
        choice = gets.chomp.downcase
        file = @directory + choice + '.yaml'
        if File.exist? file
            load_game(file)
        else
            load_game_confirmation
        end
    end
    def load_game(file)
        data = YAML::load(File.open(file,'r'))
        @player_name = data[:player_name]
        @mystery_word = data[:mystery_word]
        @misses = data[:misses]
        @round = data[:round]
        @word = data[:word]
    end
    def draw
        puts "\n_____________________________________"
        puts "ROUND #{@round}"
        puts "MYSTERY WORD: #{@mystery_word}"
        puts "TRIES LEFT #{5-@misses.length}"
        puts "MISSES: #{@misses.join(' ')}"
    end
end


