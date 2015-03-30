class Eightqueens
  Q = true
  def self.empty
    Array.new(8) { Array.new(8) }

  end
  def initialize(board = self.class.empty)
    @board = board 
    @valid_board = Array.new(8) { Array.new(8, true) }
  end

  attr_accessor :board, :valid_board

  def valid_spot?(row,col)
    @valid_board[row][col]
  end

  def place_queen(row, col)
    @board[row][col] = Q unless @board[row][col]
    invalidate_rows(row)
    invalidate_cols(col)
    invalidate_diags(row, col)
  end

  def display_board
    display = @board
    display.map do |row|
      row.map do |col|
        col ? "Q" : " "
      end
    end.each do |row|
      p row
    end

    # @valid_board.each do |row|
    #   p row
    # end

  end

  def solved?
    @board.each do |row|
      count = 0
      row.each do |col|
        count+=1 if col==true
      end
      return false unless count == 1
    end
    true
  end

  def no_valid?
    invalid_board = Array.new(8){Array.new(8, false)}
    @valid_board == invalid_board

  end

  protected
  def invalidate_rows(row)
    (0..7).each do |i|
      @valid_board[row][i] = false
    end

  end

  def invalidate_cols(col)
    (0..7).each do |i|
      @valid_board[i][col] = false
    end
  end

  def invalidate_diags(row,col)
    # go southeast [+1,+1]
    invalidate_left_down(row, col)
    invalidate_left_up(row, col)
    invalidate_right_up(row,col)
    invalidate_right_down(row,col)
  end

  def invalidate_left_down(row, col)
    unless row == 7 
      ((row+1)..7).each do |row|
        col -= 1 
        @valid_board[row][col] = false if col >= 0
      end
    end
  end

  def invalidate_left_up(row, col)
    unless row == 0 
      (row-1).downto(0).each do |row|
        col -= 1
        @valid_board[row][col] = false if col >= 0
      end
    end
  end

  def invalidate_right_up(row, col)
    unless row == 0 
      (row-1).downto(0).each do |row|
        col += 1
        @valid_board[row][col] = false if col <= 7
      end
    end
  end

  def invalidate_right_down(row, col)
    unless row == 7 
      ((row+1)..7).each do |row|
        col += 1 
        @valid_board[row][col] = false if col <= 7
      end
    end
  end

  

end

class Solver
  def initialize
    @puzzle = Eightqueens.new
  end

  def play
    user_interact

    @puzzle.display_board
    if @puzzle.solved?
      puts "You win!"
    elsif @puzzle.no_valid?
      puts "No more valid moves. You lose!"
    else
      play
    end
  end

  def user_interact
    puts "Choose which row to place queen:"
    row = gets.chomp.to_i
    puts "Choose which column to place queen:"
    col = gets.chomp.to_i
    if @puzzle.valid_spot?(row, col)
      @puzzle.place_queen(row, col) 
    else
      puts "Not a valid spot to place a queen."
    end

  end
end

if __FILE__ == $PROGRAM_NAME
  Solver.new.play
end

