class Character < ApplicationRecord
    has_and_belongs_to_many :items
    belongs_to :character_class
    belongs_to :primary_spec, class_name: "Specialization", foreign_key: "primary_spec_id"
    belongs_to :secondary_spec, class_name: "Specialization", foreign_key: "secondary_spec_id"

    enum :character_class => { "paladin"=>0, "warrior"=>1, "hunter"=>2, "rogue"=>3, "priest"=>4, "shaman"=>5, "mage"=>6, "warlock"=>7, "druid"=>8, "death_knight"=>9 }
end
