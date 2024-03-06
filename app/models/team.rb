require 'securerandom'

class Team < ApplicationRecord
    belongs_to :user
    has_many :runs
    has_many :team_characters, :class_name => "TeamCharacter"
    has_many :characters, through: :team_characters

    before_create :create_invite_code

    def create_invite_code
        loop do
            self. invite_code = SecureRandom.hex(3)
            break unless self.class.exists?(:invite_code => invite_code)
        end
    end

    def spells
        characters.map{|character| character.primary_spec.spells}.flatten
    end

    def as_json(options = {})
        out = {}
        [:id, :name, :user_id, :characters, :spells, :version_id].each do |key|
            out[key] = self.send(key)
        end
        out
    end
end
