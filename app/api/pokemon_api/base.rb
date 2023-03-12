module PokemonApi
  class Base < Grape::API
    mount PokemonApi::V1::Pokemons
  end
end