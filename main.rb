require_relative 'lib/game.rb'

hangman = Game.new('google-10000-english-no-swears.txt')

hangman.play
