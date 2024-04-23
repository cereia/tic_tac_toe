# frozen_string_literal: true

# create a tic tac toe game where two humans can play
# the board is meant to be displayed in the console after every player turn
class Board
  attr_reader :board

  def initialize
    @board = []
    0.upto(8) { |i| @board[i] = '' }
    p board
  end

  def place(mark, position)
    board[position - 1] = mark
    p board
  end
end

a = Board.new
a.place('X', 3)
