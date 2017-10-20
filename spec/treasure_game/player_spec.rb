require 'treasure_game/player'
require 'treasure_game/treasure_trove'

module TreasureGame
  describe Player do

    before do
      $stdout = StringIO.new
      @initial_health = 150
      @player = Player.new("larry", @initial_health)
    end

    it "has a capitalized name" do
      expect(@player.name).to eq("Larry")
    end

    it "has an initial health" do
      expect(@player.health).to eq(150)
    end

    it "has a string representation" do
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:hammer, 50))

      expect(@player.to_s).to eq("I'm Larry with health = 150, points = 100, and score = 250.")
      end

    it "computes a score as the sum of its health and points" do
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:hammer, 50))

      expect(@player.score).to eq(250)
    end

    it "increases health by 15 when w00ted" do
      @player.w00t
      expect(@player.health).to eq(@initial_health + 15)
    end

    it "decreases health by 10 when blammed" do
      @player.blam
      expect(@player.health).to eq(@initial_health - 10)
    end

    context "with a health greater than 100" do
      before do
        initial_health = 150
        @player = Player.new("Bob", initial_health)
      end

      it "is strong" do
        expect(@player.strong?).to be true
      end
    end

    context "with a health of less than or equal to 100" do
      before do
        initial_health = 100
        @player = Player.new("Bob", initial_health)
      end

      it "is weak" do
        expect(@player.strong?).to be false
      end
    end

    it "computes points as the sum of all treasure points" do
      expect(@player.points).to eq(0)

      @player.found_treasure(Treasure.new(:hammer, 50))

      expect(@player.points).to eq(50)

      @player.found_treasure(Treasure.new(:crowbar, 400))

      expect(@player.points).to eq(450)

      @player.found_treasure(Treasure.new(:hammer, 50))

      expect(@player.points).to eq(500)
    end

    it "yields each found treasure and its total points" do
      @player.found_treasure(Treasure.new(:skillet, 100))
      @player.found_treasure(Treasure.new(:skillet, 100))
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))

      yielded = []
      @player.each_found_treasure do |treasure|
        yielded << treasure
      end

      expect(yielded).to eq([
        Treasure.new(:skillet, 200),
        Treasure.new(:hammer, 50),
        Treasure.new(:bottle, 25)
     ])
    end

    it "can be created from a CSV string" do
      player = Player.from_csv("larry,150")

      expect(player.name).to eq("Larry")
      expect(player.health).to eq(150)
    end
  end
end
