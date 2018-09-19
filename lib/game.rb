class Game
  attr_reader :board, :winning_player, :players, :current_player
  def initialize
    @players = []
    @winning_player = nil
    @current_player = nil
    @board = [[0,0,0,0,0,0,0],
              [0,0,0,0,0,0,0],
              [0,0,0,0,0,0,0],
              [0,0,0,0,0,0,0],
              [0,0,0,0,0,0,0],
              [0,0,0,0,0,0,0]]
  end

  def start
    puts "Welcome to Connect Four!"
    add_players
    game_loop
    game_end
  end

  def add_players
    @players << get_input("Player 1, Enter name: ")
    @players << get_input("Player 2, Enter name: ")
  end

  def get_input(prompt, int = false)
    print prompt
    input = gets.chomp
    return int ? input.to_int : input
  end

  def game_loop
    return if won?
    change_player
    display_board
    select_column
  end

  def won?
    if four_in_a_row?
      return true
    else
      return false
    end
  end

  def display_board
    puts "\n"
    @board.each do |row|
      print "|"
      row.each {|slot| print " #{slot} "}
      puts "|"
    end
    puts "-" * 23
    7.times do |num|
      print "  #{num + 1}"
    end
    puts "\n"
  end

  def four_in_a_row?
    permutations = []
    permutations.push(*horizontal_lines)
    permutations.push(*vertical_lines)
    # permutations.push(*right_incline_lines)
    # permutations.push(*left_incline_lines)

    scan(permutations)
  end

  def horizontal_lines
    result = []
    @board.each do |row|
      row.map! {|x| x.to_s}
      result << row.join("")
    end
    result
  end

  def vertical_lines
    result = []
    counter = 0
    while counter < board[0].length
      column = ""
      @board.each do |row|
        column += row[counter].to_s
      end
      result << column
      counter += 1
    end
    result
  end

  def right_incline_lines

  end

  def left_incline_lines

  end

  def scan(permutations)
    permutations.each do |string|
      if /1{4}/ =~ string
        @winning_player = 0
        return true
      elsif /2{4}/ =~ string
        @winning_player = 1
        return true
      end
    end
    return false
  end

  def game_end

  end

  def select_column
    loop do
      column = get_input("Pick a column for your token #{@players[@current_player]}: ", true) - 1
      if valid_column?(column)
        drop_token(column)
        return
      end
      puts "Bad input"
    end
  end

  def valid_column?(column)

  end

  def drop_token(column)

  end

  def change_player
    if @current_player == @players[0]
      @current_player = @players[1]
    else
      @current_player = @players[0]
    end
  end
end