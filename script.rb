# frozen_string_literal: true

# create a tic tac toe game where two humans can play
# the board is meant to be displayed in the console after every player turn
class Board
  attr_reader :board, :round

  def initialize(hash)
    @board = []
    0.upto(8) { |i| @board[i] = '' }
    @round = 0
    @player1 = hash[:player1]
    @player2 = hash[:player2]
    puts "Player 1: #{@player1} Player 2: #{@player2}"
    puts "Board created: #{board}"
  end

  def place(mark, position)
    @round += 1
    if board[position - 1] == ''
      board[position - 1] = mark
    else
      puts 'There\'s already a symbol there. Please choose again.'
    end
    puts "Round: #{@round} #{board}"
  end
end

def play_game
  puts 'Would you like to play tic tac toe? Y/N'
  answer = gets
  if answer[0].match(/y/i)
    board = Board.new(assign_symbol)
  elsif answer[0].match(/n/i)
    puts ':( No tic tac toe'
  else
    play_game
  end
  board
end

def assign_symbol
  puts 'Do you want to be X or O?'
  mark = gets.chomp
  if mark.match(/x/i) || mark.match(/o/i)
    player1 = (mark.match(/x/i) || mark.match(/o/i)).to_s.upcase
    player2 = player1 == 'X' ? 'O' : 'X'
    { player1: player1, player2: player2 }
  else
    assign_symbol
  end
end

# run to start the game and create a board
play_game

{
  horizontal: [[1, 2, 3], [4, 5, 6], [7, 8, 9]],
  vertical: [[1, 4, 7], [2, 5, 8], [3, 6, 9]],
  diagonal: [[1, 5, 9], [3, 5, 7]]
}

# a = Board.new
# a.place('X', 4)
# a.place('O', 5)
# puts a.round
