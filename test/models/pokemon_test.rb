require "test_helper"

class PokemonTest < ActiveSupport::TestCase
  test "total is properly computed" do
    assert_equal(Pokemon.find_by!(name: "Bulbasaur").total, 571)
  end

  test "stats cannot be negative" do
    pokemon = Pokemon.find_by!(name: "Bulbasaur")
    Pokemon::STATS_ATTRIBUTES.each do |attribute|
      pokemon[attribute] =  -2
      assert_raises(ActiveRecord::RecordInvalid) { pokemon.save! }
    end
  end
end
