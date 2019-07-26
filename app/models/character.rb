class Character < ApplicationRecord
    belongs_to :char_class
    has_many :skill_proficiencies
    has_many :skills, through: :skill_proficiencies
    has_many :character_proficiencies
    has_many :proficiencies, through: :character_proficiencies
end
