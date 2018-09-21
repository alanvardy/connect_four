class Game
  attr_reader :board, :winning_player, :players, :current_player
  def initialize
    @players = []
    @winning_player = nil
    @current_player = nil
    @player_number = nil
    @board = create_board(7, 6)
  end

  def start
    puts "Welcome to Connect Four!"
    change_board
    add_players
    game_loop
    game_end
  end

  def change_board
    puts "The default board size is 7 wide by 6 high,"
    return unless get_input("would you like to change it? y/n: ") == "y"
    width = get_input("Enter width: ", true)
    height = get_input("Enter height: ", true)
    create_board(width, height)
  end

  def create_board(width, height)
    row = Array.new(width, 0)
    @board = Array.new(height, row)
  end

  def add_players
    @players << get_input("Player 1, Enter name: ")
    @players << get_input("Player 2, Enter name: ")
  end

  def get_input(prompt, int = false)
    print prompt
    input = gets.chomp
    return int ? input.to_i : input
  end

  def game_loop
      change_player
      display_board
      select_column
      game_loop unless won?
  end

  def won?
    if four_in_a_row?
      return true
    else
      return false
    end
  end

  def display_board
    puts "\n\n"
    @board.each do |row|
      print "|"
      row.each {|slot| print " #{slot} "}
      puts "|"
    end
    puts "-" * (@board[0].length * 3 + 2)
    @board[0].length.times do |num|
      print "  #{num + 1}"
    end
    puts "\n\n"
  end

  def four_in_a_row?
    permutations = []
    permutations.push(*horizontal_lines)
    permutations.push(*vertical_lines)
    permutations.push(*incline_lines)
    scan(permutations)
  end

  def horizontal_lines
    result = []
    @board.each do |row|
      new_row = row.map {|x| x.to_s}
      result << new_row.join("")
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

  def incline_lines
    permutations = []
    bottom_row = @board.length - 1
    last_column = @board[0].length-1
    ycounter = 0
    @board.each do |row|
      permutations.push(right_incline(row[0].to_s, 0, ycounter))
      permutations.push(left_incline(row[last_column].to_s, last_column, ycounter))
      ycounter += 1
    end
    xcounter = 0
    @board[bottom_row].each do |start|
      permutations.push(right_incline(start.to_s, xcounter, bottom_row))
      permutations.push(left_incline(start.to_s, xcounter, bottom_row))
      xcounter += 1
    end
    return permutations
  end

  def right_incline(start, x, y)
    return start unless y > 0 && x < @board[0].length - 1
    start += @board[y - 1][x + 1].to_s
    x += 1
    y -= 1
    right_incline(start, x, y)
  end

  def left_incline(start, x, y)
    return start unless y > 0 && x > 0
    start += @board[y - 1][x - 1].to_s
    x -= 1
    y -= 1
    left_incline(start, x, y)
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
    display_board
    puts "GAME WON! #{@current_player} is the winner!"
  end

  def select_column
    loop do
      column = get_input("Pick a column for your token #{@current_player}: ", true)
      column -= 1
      if valid_column?(column)
        drop_token(column)
        break
      end
      puts "Bad input"
    end
  end

  def valid_column?(column)
    return false unless @board[0][column] == 0
    return false unless column >= 0 && column < @board[0].length
    return true
  end

  def drop_token(column, row = board.length-1)
    if @board[row][column] == 0
      @board[row][column] = @player_number
      return
    else
      drop_token(column, row - 1)
    end
  end

  def change_player
    if @player_number == 1
      @current_player = @players[1]
      @player_number = 2
    else
      @current_player = @players[0]
      @player_number = 1
    end
  end
end