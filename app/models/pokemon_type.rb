class PokemonType < ApplicationRecord

  validates :name, presence: true, uniqueness: true
end
