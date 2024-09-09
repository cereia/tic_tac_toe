# frozen_string_literal: true

# create a tic tac toe game where two humans can play on the command line
# the board is meant to be displayed in the console after every player turn

require_relative 'lib/board'
require_relative 'lib/game'

# uncomment to start the game
game = Game.new
game.play_game
