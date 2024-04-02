require 'securerandom'

class Team < ApplicationRecord
    belongs_to :user
    has_many :runs, dependent: :nullify
    has_many :team_characters, :class_name => "TeamCharacter"
    has_many :characters, through: :team_characters
    has_many :team_codes, :class_name => "TeamCodeCharacter", :foreign_key => "team_id"
    has_many :team_code_characters, :through=> :team_codes, :source => :character

    enum :faction => { "Alliance"=>0, "Horde"=>1}

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
        [:id, :name, :user_id, :characters, :team_code_characters, :invite_code, :spells, :version_id, :faction].each do |key|
            out[key] = self.send(key)
        end
        out
    end
end
