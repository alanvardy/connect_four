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
      expect(game).to receive(:add_players)
      game.start
    end
    it 'calls game_loop' do
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
      pending 'need to fix this'
      # expect(STDIN).to receive(:gets).and_return('yes')
      # expect(game.players[0].name).to eq("Test")
    end
  end

  describe '#game_loop' do
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