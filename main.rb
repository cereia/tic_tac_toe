# frozen_string_literal: true

# create a tic tac toe game where two humans can play on the command line
# the board is meant to be displayed in the console after every player turn

require_relative 'lib/board'
require_relative 'lib/game'

# uncomment to start the game
# game = Game.new
# game.play_game

# NOTE: #play_round call in the Game class #place_mark has to be commented out for testing
# NOTE: #assign_symbol call in the Board class #initialize has to be commented out for testing
# NOTE: #curren_board call in Board class #initialize can be left alone for testing because it's only puts,
# but it's preferred to remove it to make test results less bulky and easier to read
