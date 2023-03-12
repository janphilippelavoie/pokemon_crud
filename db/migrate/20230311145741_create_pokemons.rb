class CreatePokemons < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemons do |t|
      t.string :name, null: false, unique: true
      t.integer :hp, null: false
      t.integer :attack, null: false
      t.integer :defense, null: false
      t.integer :sp_attack, null: false
      t.integer :sp_defense, null: false
      t.integer :speed, null: false
      t.integer :generation, null: false
      t.boolean :legendary, null: false, default: false

      t.references :type_1, null: false
      t.references :type_2, null: true

      t.timestamps
    end

    add_foreign_key :pokemons, :pokemon_types, column: :type_1_id, primary_key: :id
    add_foreign_key :pokemons, :pokemon_types, column: :type_2_id, primary_key: :id
  end
end
