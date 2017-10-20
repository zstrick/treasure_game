require 'treasure_game/game'

module TreasureGame
  describe Game do

    before do
      @game = Game.new("Knuckleheads")

      @initial_health = 100
      @player = Player.new("moe", @initial_health)

      @game.add_player(@player)
      $stdout = StringIO.new
    end

    it "w00ts the player if a high number is rolled" do
      allow_any_instance_of(Die).to receive(:roll).and_return(5)

      @game.play(2)

      expect(@player.health).to eq(@initial_health + (15 * 2))
    end

    it "skips the player if a medium number is rolled" do
      allow_any_instance_of(Die).to receive(:roll).and_return(3)

      @game.play(2)

      expect(@player.health).to eq(@initial_health)
    end

    it "blams the player if a low number is rolled" do
      allow_any_instance_of(Die).to receive(:roll).and_return(1)

      @game.play(2)

      expect(@player.health).to eq(@initial_health - (10 * 2))
    end

    context "in a collection of players" do
      before do
        @player1 = Player.new("moe", 100)
        @player2 = Player.new("larry", 200)
        @player3 = Player.new("curly", 300)

        @players = [@player1, @player2, @player3]
      end

      it "is sorted by decreasing score" do
        expect(@players.sort).to eq([@player3, @player2, @player1])
      end
    end

    it "assigns a treasure for points during a player's turn" do
      game = Game.new("Knuckleheads")
      player = Player.new("moe")

      game.add_player(player)

      game.play(1)

      expect(player.points).not_to be_zero
    end

    it "computes total points as the sum of all player points" do
      game = Game.new("Knuckleheads")

      player1 = Player.new("moe")
      player2 = Player.new("larry")

      game.add_player(player1)
      game.add_player(player2)

      player1.found_treasure(Treasure.new(:hammer, 50))
      player1.found_treasure(Treasure.new(:hammer, 50))
      player2.found_treasure(Treasure.new(:crowbar, 400))

      expect(game.total_points).to eq(500)
    end
  end
end
