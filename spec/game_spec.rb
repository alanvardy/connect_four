require 'game.rb'
describe Game do
  before do
    allow($stdout).to receive(:write)
  end
  let(:game) {game ||= Game.new}
  context 'when initialized' do
    it 'creates a player list' do
      expect(game.players).to eq([])
    end
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
      expect(game.players.length).to eq(1)
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

  describe '#four_in_a_row' do
    pending 'todo'
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

describe Player do
  context 'when initialized' do
    it 'creates a player' do
      player = Player.new("Test", "#")
      expect(player.name).to eq("Test")
      expect(player.symbol).to eq("#")
    end
  end
end