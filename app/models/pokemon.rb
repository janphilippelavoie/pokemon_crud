class Pokemon < ApplicationRecord
  STATS_ATTRIBUTES = %i[hp attack defense sp_attack sp_defense speed].freeze

  belongs_to :type_1, class_name: PokemonType.name
  belongs_to :type_2, class_name: PokemonType.name, optional: true

  STATS_ATTRIBUTES.each do |stat_attribute|
    validates stat_attribute, presence: true, numericality: { greater_than_or_equal_to: 0 }
  end

  validates :generation, presence: true, numericality: { greater_than: 0 }

  def total
    STATS_ATTRIBUTES.sum { |s| self[s] }
  end
end
