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
    if board[position - 1] == ''
      board[position - 1] = mark
    else
      puts 'There\'s already a symbol there. Please choose again.'
    end
    p board
  end
end

def play_game
  puts 'Would you like to play tic tac toe? Y/N'
  answer = gets
  if answer[0].match(/y/i)
    assign_symbol
    Board.new
  elsif answer[0].match(/n/i)
    puts ':( No tic tac toe'
  else
    play_game
  end
end

def assign_symbol
  puts 'Do you want to be X or O?'
  mark = gets.chomp
  if mark.match(/x/i) || mark.match(/o/i)
    player1 = (mark.match(/x/i) || mark.match(/o/i)).to_s.upcase
    player2 = player1 == 'X' ? 'O' : 'X'
    marks = { player1: player1, player2: player2 }
    puts "Here are your players: #{marks}"
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
