class Run < ApplicationRecord
    belongs_to :team
    belongs_to :raid
    has_many :characters
    has_many :battles
    has_many :drops, through: :battles
end