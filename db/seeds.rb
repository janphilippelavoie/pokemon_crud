# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'

raw_csv = File.read('lib/seeds/pokemon_seed.csv')
csv = CSV.parse(raw_csv, headers: true)
ActiveRecord::Base.transaction do
  csv.each do |row|
    type1 = row["Type 1"]
    type2 = row["Type 2"]
    types = []
    types << PokemonType.find_or_create_by!(name: type1) unless type1.nil?
    types << PokemonType.find_or_create_by!(name: type2) unless type2.nil?
  end
end