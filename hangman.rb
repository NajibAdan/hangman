require_relative 'game.rb'
require_relative 'player.rb'
game = Game.new()
player = Player.new()

puts "DO YOU WANT TO LOAD A SAVE FILE"
choice = gets.chomp.downcase
if choice[0] == 'y'
    game.load_game_confirmation
else
    game.choose_word
end
while !game.game_over? do
    game.draw
    game.guess = player.guess
    game.check_letter
end
