class Game
  attr_reader :players, :board
  def initialize
    @players = []
    @board = [[00,01,02,03,04,05],
              [10,11,12,13,14,15],
              [20,21,22,23,24,25],
              [30,31,32,33,34,35],
              [40,41,42,43,44,45],
              [50,51,52,53,54,55],
              [60,61,62,63,64,65]]
  end

  def start
    puts "Welcome to Connect Four!"
    add_players
    game_loop
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

  end

  def won?
    if four_in_a_row?
      return true
    else
      return false
    end
  end

  def four_in_a_row?

  end
end

class Player
  attr_reader :name, :symbol
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end