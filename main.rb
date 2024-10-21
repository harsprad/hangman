require_relative 'lib/game.rb'
require 'yaml'

saves = Dir.children('saves')
puts "Would you like to recover a save? (Y/n)"
game_type = gets.chomp

if game_type == "n" || saves.length == 0
  hangman = Game.new('google-10000-english-no-swears.txt')
else
  saves.each_with_index do |save, i|
    guess_state, time = save.split('.')[0].split('-')
    puts "##{i}: #{Time.at(time.to_i)} with guess #{guess_state}"
  end
  puts "Type the index of the one you want to play"
  begin 
    index = gets.chomp.to_i
    file_name = saves[index]
  rescue
    puts "The index has to be a number representing a save file listed"
    retry
  end
  saved_game = File.read("saves/#{file_name}")
  hangman = YAML::load(saved_game, permitted_classes: [Game])
end

hangman.play
