module PokemonApi
  module V1
    class Pokemons < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api
      resource :pokemons do
        desc 'Return list of pokemons'
        get do
          present Pokemon.all
        end
      end

      resource :pokemon

      params
    end
  end
end
