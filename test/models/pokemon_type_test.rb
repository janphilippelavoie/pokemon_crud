require "test_helper"

class PokemonTypeTest < ActiveSupport::TestCase
  test "types cannot have duplicate names" do
    PokemonType.create!(name: "Poison")
    assert_raises(ActiveRecord::RecordInvalid) { PokemonType.create!(name: "Poison") }
  end
end
