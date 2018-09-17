class Game
  attr_reader :players, :board
  def initialize
    @players = []
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
    symbol = get_input("Player #{num}, Enter symbol: ")
    @players << Player.new(name, symbol)
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

  end

  def game_end

  end

  def select_column

  end

  def change_player

  end
end

class Player
  attr_reader :name, :symbol
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end