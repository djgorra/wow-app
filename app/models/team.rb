class Team < ApplicationRecord
    belongs_to :user
    has_many :runs
    has_many :team_characters, :class_name => "TeamCharacter"
    has_many :characters, through: :team_characters
end
