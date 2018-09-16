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
      allow(game).to receive(:game_loop)
      expect(game).to receive(:add_players)
      game.start
    end
    it 'calls game_loop' do
      allow(game).to receive(:add_players)
      expect(game).to receive(:game_loop)
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
    pending 'todo'
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

  describe '#four_in_a_row' do
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