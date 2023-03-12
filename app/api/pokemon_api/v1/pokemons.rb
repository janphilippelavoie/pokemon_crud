module PokemonApi
  module V1
    module Helpers
      def self.model_to_json(pokemon)
        {
          id: pokemon.id,
          name: pokemon.name,
          type_1: pokemon.type_1&.name,
          type_2: pokemon.type_2&.name,
          generation: pokemon.generation,
          legendary: pokemon.legendary,
          stats: {
            hp: pokemon.hp,
            attack: pokemon.attack,
            defense: pokemon.defense,
            sp_attack: pokemon.sp_attack,
            sp_defense: pokemon.sp_defense,
            speed: pokemon.speed,
            total: pokemon.total
          }
        }
      end

      def self.json_to_model(params)
        model_params = {}
        model_params[:name] = params[:name]
        model_params[:type_1] = PokemonType.find_by(name: params[:type_1])
        model_params[:type_2] = PokemonType.find_by(name: params[:type_2])
        model_params[:generation] = params[:generation]
        model_params[:legendary] = params[:legendary]
        model_params[:hp] = params.dig(:stats, :hp)
        model_params[:attack] = params.dig(:stats, :attack)
        model_params[:defense] = params.dig(:stats, :defense)
        model_params[:sp_attack] = params.dig(:stats, :sp_attack)
        model_params[:sp_defense] = params.dig(:stats, :sp_defense)
        model_params[:speed] = params.dig(:stats, :speed)
        model_params.filter { |k, v| v.present? } # We remove all nil keys to prevent overwriting missing values with nil
      end
    end

    class Pokemons < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :pokemon do

        desc 'Return a list of pokemons'
        get do
          present Pokemon.find_each.map { |p| Helpers.model_to_json(p) }
        end

        params do
          requires :name, type: String, desc: "Name of the pokemon"
          requires :type_1, type: String, desc: "Primary type of pokemon"
          optional :type_2, type: String, desc: "Secondary type of pokemon"
          requires :generation, type: Integer, desc: "generation of pokemon"
          requires :legendary, type: Boolean, desc: "Whether the pokemon is legendary or not"
          requires :stats, type: Hash, desc: "Statline of the pokemon" do
            requires :hp, type: Integer
            requires :attack, type: Integer
            requires :defense, type: Integer
            requires :sp_attack, type: Integer
            requires :sp_defense, type: Integer
            requires :speed, type: Integer
          end
        end
        post do
          pokemon = Pokemon.create!(Helpers.json_to_model(params))
          present Helpers.model_to_json(pokemon)
        end

        route_param :id do
          get do
            pokemon = Pokemon.find_by(id: params[:id])
            if pokemon
              present Helpers.model_to_json(pokemon)
            else
              status 404
              { error: "No pokemon found with id: #{params[:id]}" }
            end
          end

          delete do
            pokemon = Pokemon.find_by(id: params[:id])
            if pokemon
              pokemon.destroy!
              present Helpers.model_to_json(pokemon)
            else
              status 404
              { error: "No pokemon found with id: #{params[:id]}" }
            end
          end

          params do
            optional :name, type: String, desc: "Name of the pokemon"
            optional :type_1, type: String, desc: "Primary type of pokemon"
            optional :type_2, type: String, desc: "Secondary type of pokemon"
            optional :generation, type: Integer, desc: "generation of pokemon"
            optional :legendary, type: Boolean, desc: "Whether the pokemon is legendary or not"
            optional :stats, type: Hash, desc: "Statline of the pokemon" do
              optional :hp, type: Integer
              optional :attack, type: Integer
              optional :defense, type: Integer
              optional :sp_attack, type: Integer
              optional :sp_defense, type: Integer
              optional :speed, type: Integer
            end
          end
          put do
            pokemon = Pokemon.find_by(id: params[:id])
            if pokemon
              pokemon.update!(Helpers.json_to_model(params))
              present Helpers.model_to_json(pokemon)
            else
              status 404
              { error: "No pokemon found with id: #{params[:id]}" }
            end
          end
        end

        # end
      end
    end
  end
end

