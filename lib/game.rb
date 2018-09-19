class Game
  attr_reader :board, :winning_player, :player1, :player2
  def initialize
    @player1 = nil
    @player2 = nil
    @winning_player = nil
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
    2.times {|num| add_player(num)}
  end

  def add_player(num)
    name = get_input("Player #{num}, Enter name: ")
    if num == 1
      @player1 = name
    elsif num == 2
      @player2 = name
    end
  end

  def get_input(prompt, int = false)
    print prompt
    input = gets.chomp
    return int ? input.to_int : input
  end

  def game_loop
    return if won?
    display_board
    select_column
    change_player
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
        @winning_player = 1
        return true
      elsif /2{4}/ =~ string
        @winning_player = 2
        return true
      end
    end
    return false
  end

  def game_end

  end

  def select_column
    loop do
      column = get_input("Pick a column for your token: ", true) - 1
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

  end
end