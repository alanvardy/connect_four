require 'game.rb'
describe Game do
  before do
    allow($stdout).to receive(:write)
  end
  let(:game) {game ||= Game.new}

  context 'when initialized' do
    it 'creates the board' do
      expect(game.board).to be_truthy
    end
  end

  describe '#start' do
    it 'calls add_players' do
      allow(game).to receive(:game_end)
      allow(game).to receive(:game_loop)
      expect(game).to receive(:add_players)
      game.start
    end
    it 'calls game_loop' do
      allow(game).to receive(:game_end)
      allow(game).to receive(:add_players)
      expect(game).to receive(:game_loop)
      game.start
    end
    it 'calls game_end' do
      expect(game).to receive(:game_end)
      allow(game).to receive(:add_players)
      allow(game).to receive(:game_loop)
      game.start
    end
  end

  describe '#add_players' do
    it 'creates a player' do
      allow(game).to receive(:get_input).and_return('test')
      game.add_players
      expect(game.players).to eq(['test', 'test'])
    end
  end

  describe '#game_loop' do
    context 'when game is won' do
      it 'goes to the game_end method' do
        allow(game).to receive(:change_player)
        allow(game).to receive(:display_board)
        allow(game).to receive(:select_column)
        allow(game).to receive(:won?).and_return(true)
        expect(game).to receive(:game_loop).once
        game.game_loop
      end
    end
    context 'when game isn\'t won' do
      it 'loops again' do
        allow(game).to receive(:change_player)
        allow(game).to receive(:display_board)
        allow(game).to receive(:select_column)
        expect(game).to receive(:won?).exactly(3).times.and_return(false, false, true)
        game.game_loop
      end
      it 'sets the player' do
        expect(game).to receive(:change_player)
        allow(game).to receive(:display_board)
        allow(game).to receive(:select_column)
        allow(game).to receive(:won?).and_return(true)
        game.game_loop
      end
      it 'displays the board' do
        allow(game).to receive(:change_player)
        expect(game).to receive(:display_board)
        allow(game).to receive(:select_column)
        allow(game).to receive(:won?).and_return(true)
        game.game_loop
      end
      it 'asks player to set the column' do
        allow(game).to receive(:change_player)
        allow(game).to receive(:display_board)
        expect(game).to receive(:select_column)
        allow(game).to receive(:won?).and_return(true)
        game.game_loop
      end
    end
  end

  describe '#won?' do
    context 'when 4 in a row' do
      it 'returns true' do
        allow(game).to receive(:four_in_a_row?).and_return(true)
        expect(game.won?).to be(true)
        game.won?
      end
    end
    context 'when not 4 in a row' do
      it 'returns false' do
        allow(game).to receive(:four_in_a_row?).and_return(false)
        expect(game.won?).to be(false)
        game.won?
      end
    end
  end

  describe '#display_board' do
    #unable to test visual output
  end

  describe '#four_in_a_row?' do
    context 'when scan is true' do
      it 'returns true' do
        allow(game).to receive(:horizontal_lines).and_return(1)
        allow(game).to receive(:vertical_lines).and_return(1)
        allow(game).to receive(:incline_lines).and_return(1)
        allow(game).to receive(:scan).and_return(true)
        expect(game.four_in_a_row?).to be(true)
      end
    end

    context 'when not 4 in a row' do
      it 'returns false' do
        allow(game).to receive(:horizontal_lines).and_return(1)
        allow(game).to receive(:vertical_lines).and_return(1)
        allow(game).to receive(:incline_lines).and_return(1)
        allow(game).to receive(:scan).and_return(false)
        expect(game.four_in_a_row?).to be(false)
      end
    end
  end

  describe '#horizontal_lines' do
    it 'turns horizontal array elements in strings' do
      game.instance_variable_set(:@board, [[1,1],[2,2]])
      expect(game.horizontal_lines).to eq(["11", "22"])
    end
  end

  describe '#vertical_lines' do
    it 'turns vertical array elements in strings' do
      game.instance_variable_set(:@board, [[1,1],[2,2]])
      expect(game.vertical_lines).to eq(["12", "12"])
    end
  end

  describe '#incline_lines' do
    pending 'todo'
  end

  describe '#right_incline' do
    pending 'todo'
  end

  describe '#left_incline' do
    pending 'todo'
  end

  describe '#scan' do
    context 'when given an array of strings with 4 ones within' do
      it 'returns true' do
        expect(game.scan(["00000","00222","00011110"])).to be(true)
      end
      it 'sets player 1 as winner' do
        game.scan(["00000","00222","00011110"])
        expect(game.winning_player).to eq(0)
      end
    end
    context 'when given an array of strings with 4 twos within' do
      it 'returns true' do
        expect(game.scan(["00000","00111","00022220"])).to be(true)
      end
      it 'sets player 2 as winner' do
        game.scan(["00000","00111","00022220"])
        expect(game.winning_player).to eq(1)
      end
    end
  end

  describe '#game_end' do
    it 'shows the display board' do
      expect(game).to receive(:display_board)
      game.game_end
    end
  end

  describe '#select_column' do
    context 'when given good input' do
      it 'calls drop_token with input-1' do
        allow(game).to receive(:get_input).and_return(3)
        allow(game).to receive(:valid_column?).and_return(true)
        expect(game).to receive(:drop_token).with(2)
        game.select_column
      end
    end
    context 'when given bad input' do
      it 'repeats itself again' do
        allow(game).to receive(:get_input).twice.and_return(3)
        allow(game).to receive(:valid_column?).and_return(false, true)
        expect(game).to receive(:drop_token).with(2)
        game.select_column
      end
    end
  end

  describe '#valid_column?' do
    context 'when column is full' do
      it 'returns false' do
        game.instance_variable_set(:@board, [[0,0,1,1],[1,1,1,1]])
        expect(game.valid_column?(2)).to be(false)
      end
    end
    context 'when column doesn\'t exist' do
      it 'returns false' do
        expect(game.valid_column?(8)).to be(false)
      end
    end
    context 'when valid' do
      it 'returns true' do
        expect(game.valid_column?(2)).to be(true)
      end
    end
  end

  describe '#drop_token' do
    context 'when a column is entered' do
      it 'drops a token in that column' do
        game.instance_variable_set(:@player_number, 2)
        game.drop_token(2)
        expect(game.board[game.board.length - 1][2]).to eq(2)
      end
    end
  end

  describe '#change_player' do
    before do
      game.instance_variable_set(:@players, ["Person1", "Person2"])
    end
    context 'when current player is 0' do
      it 'sets current player to 1' do
        game.instance_variable_set(:@player_number, 1)
        game.change_player
        expect(game.current_player).to eq("Person2")
      end
    end
    context 'when current player is 1' do
      it 'sets current player to 0' do
        game.instance_variable_set(:@player_number, 2)
        game.change_player
        expect(game.current_player).to eq("Person1")
      end
    end
  end
end