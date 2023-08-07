class Character < ApplicationRecord
    #has_many :character_items
    #has_many :items, through: :character_items
    belongs_to :user
    belongs_to :character_class, optional: true
    belongs_to :primary_spec, class_name: "Specialization", foreign_key: "primary_spec_id"
    belongs_to :secondary_spec, class_name: "Specialization", foreign_key: "secondary_spec_id", optional: true

    validates_presence_of :name, :user_id, :character_class_id, :primary_spec_id

    enum :race => { "human"=>0, "gnome"=>1, "dwarf"=>2, "night_elf"=>3, "draenei"=>4,
     "orc"=>7, "troll"=>8, "undead"=>9, "tauren"=>10, "blood_elf"=>11}
    enum :gender => { "male"=>0, "female"=>1}
    enum :character_class => { "paladin"=>0, "warrior"=>1, "hunter"=>2, "rogue"=>3,
     "priest"=>4, "shaman"=>5, "mage"=>6, "warlock"=>7, "druid"=>8, "death_knight"=>9 }

    def as_json(options = {})
     out = {}
      [:name, :race, :gender, :user_id].each do |key|
       out[key] = self.send(key)
     end
     out[:primary_spec]=primary_spec.as_json
     out[:secondary_spec]=secondary_spec.as_json
     out[:character_class]=character_class.as_json
     out
    end
end
