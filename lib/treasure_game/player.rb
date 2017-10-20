require_relative "treasure_trove"
require "csv"
require_relative "playable"

module TreasureGame
  class Player
    include Playable

    attr_accessor :health
    attr_accessor :name

    def initialize(name, health=100)
      @name = name.capitalize
      @health = health
      @found_treasures = Hash.new(0)
    end

    def found_treasure(treasure)
      @found_treasures[treasure.name] += treasure.points
      puts "#{@name} found a #{treasure.name} worth #{treasure.points} points."
      # puts "#{@name}'s treasures: #{@found_treasures}"
    end

    def each_found_treasure
      @found_treasures.each do |name, points|
        treasure = Treasure.new(name, points)
        yield treasure
      end
    end

    def points
      @found_treasures.values.reduce(0, :+)
    end

    def score
      @health + points
    end

    def self.from_csv(string)
      name, health = string.split(',')
      Player.new(name, Integer(health))
    end

    def to_s
      "I'm #{@name} with health = #{@health}, points = #{points}, and score = #{score}."
    end

    def name=(new_name)
      @name = new_name.capitalize
    end

    def <=>(other)
      other.score <=> score
    end
  end

  if __FILE__ == $0
    player = Player.new("moe")
    puts player.name
    puts player.health
    player.w00t
    puts player.health
    player.blam
    puts player.health
  end
end
