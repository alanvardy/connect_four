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
    it 'calls add_player twice' do
      expect(game).to receive(:add_player).twice
      game.add_players
    end
  end

  describe '#add_player' do
    it 'creates a player' do
      allow(game).to receive(:get_input).and_return('test')
      game.add_player(1)
      expect(game.player1).to eq('test')
    end
  end

  describe '#game_loop' do
    context 'when game is won' do
      it 'goes to the game_end method' do
        allow(game).to receive(:add_players)
        allow(game).to receive(:won?).and_return(true)
        expect(game).to receive(:game_end)
        game.start
      end
    end
    context 'when game isn\'t won' do
      it 'displays the board' do
        allow(game).to receive(:won?).and_return(false)
        allow(game).to receive(:select_column)
        allow(game).to receive(:change_player)
        expect(game).to receive(:display_board)
        game.game_loop
      end
      it 'asks to select the column' do
        allow(game).to receive(:won?).and_return(false)
        allow(game).to receive(:display_board)
        allow(game).to receive(:change_player)
        expect(game).to receive(:select_column)
        game.game_loop
      end
      it 'changes the player' do
        allow(game).to receive(:won?).and_return(false)
        allow(game).to receive(:display_board)
        allow(game).to receive(:select_column)
        expect(game).to receive(:change_player)
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
    context 'when player 1 has 4 in a row' do
      it 'returns true' do
        allow(game).to receive(:horizontal_lines).and_return(["0111100", "0000000"])
        expect(game.four_in_a_row?).to be(true)
      end
      it 'sets winning_player to 1' do
        allow(game).to receive(:horizontal_lines).and_return(["0111100", "0000000"])
        game.four_in_a_row?
        expect(game.winning_player).to eq(1)
      end
    end

    context 'when not 4 in a row' do
      it 'returns false' do
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

  describe '#right_incline_lines' do
    pending 'todo'
  end

  describe '#left_incline_lines' do
    pending 'todo'
  end

  describe '#scan' do
    context 'when given an array of strings with 4 ones within' do
      it 'returns true' do
        expect(game.scan(["00000","00222","00011110"])).to be(true)
      end
      it 'sets player 1 as winner' do
        game.scan(["00000","00222","00011110"])
        expect(game.winning_player).to eq(1)
      end
    end
    context 'when given an array of strings with 4 twos within' do
      it 'returns true' do
        expect(game.scan(["00000","00111","00022220"])).to be(true)
      end
      it 'sets player 2 as winner' do
        game.scan(["00000","00111","00022220"])
        expect(game.winning_player).to eq(2)
      end
    end
  end

  describe '#game_end' do
    pending 'todo'
  end

  describe '#select_column' do
    pending 'todo'
  end

  describe '#change_player' do
    pending 'todo'
  end
end