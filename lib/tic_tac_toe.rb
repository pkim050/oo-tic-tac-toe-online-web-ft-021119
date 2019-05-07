require 'pry'

class TicTacToe
  WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
  # et cetera, creating a nested array for each win combination
  ]

  def initialize(board = nil)
    @board = board || @board = Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, token = "X")
    @board[index] = token
  end

  def position_taken?(index)
    return false if @board[index] == " "
    return true
  end

  def valid_move?(index)
    if index >= 0 && index < 9
      return true if @board[index] == " "
    end
    return false
  end

  def turn
    puts "Enter a number from 1-9"
    input = gets.strip
    index = input_to_index(input)
    token = current_player
    if valid_move?(index)
      move(index, token)
      display_board
    else
      turn
    end
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.find do |element|
      return element if @board[element[0]] == "X" && @board[element[1]] == "X" && @board[element[2]] == "X"
      return element if @board[element[0]] == "O" && @board[element[1]] == "O" && @board[element[2]] == "O"
    end
    return false
  end

  def full?
    count = 0
    @board.each do |element|
      count += 1 if element == " "
    end
    return false if count > 0
    return true
  end

  def draw?
    return true if full? && !won?
    return false
  end

  def over?
    return true if won? || draw?
    return false
  end

  def winner
    WIN_COMBINATIONS.find do |element|
      return "X" if @board[element[0]] == "X" && @board[element[1]] == "X" && @board[element[2]] == "X"
      return "O" if @board[element[0]] == "O" && @board[element[1]] == "O" && @board[element[2]] == "O"
    end
    return nil
  end

  def play
    until over?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end

#game = TicTacToe.new
#binding.pry
