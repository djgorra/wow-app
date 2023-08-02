class Character < ApplicationRecord
    has_and_belongs_to_many :items
    belongs_to :character_class
    belongs_to :primary_spec, class_name: "Specialization", foreign_key: "primary_spec_id"
    belongs_to :secondary_spec, class_name: "Specialization", foreign_key: "secondary_spec_id"

    enum :race => { "human"=>0, "gnome"=>1, "dwarf"=>2, "night_elf"=>3, "draenei"=>4, "orc"=>7, "troll"=>8, "undead"=>9, "tauren"=>10, "blood_elf"=>11}
    enum :gender => { "male"=>0, "female"=>1}
    enum :character_class => { "paladin"=>0, "warrior"=>1, "hunter"=>2, "rogue"=>3, "priest"=>4, "shaman"=>5, "mage"=>6, "warlock"=>7, "druid"=>8, "death_knight"=>9 }
end
