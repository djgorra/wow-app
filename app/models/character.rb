class Character < ApplicationRecord
    has_many :character_items
    has_many :team_characters
    has_many :teams, through: :team_characters
    has_many :items, through: :character_items
    has_many :character_battles
    has_many :battles, through: :character_battles
    belongs_to :user
    belongs_to :character_class, optional: true
    belongs_to :primary_spec, class_name: "Specialization", foreign_key: "primary_spec_id"
    belongs_to :secondary_spec, class_name: "Specialization", foreign_key: "secondary_spec_id", optional: true
    has_many :wishlist_item_links, -> { where (["assigned = ?", false]) }, :foreign_key => "character_id", :class_name => "CharacterItem"
    has_many :wishlist_items, :through=>:wishlist_item_links, :class_name=>"Item", :source=>:item
    validates_presence_of :name, :user_id, :character_class_id, :primary_spec_id

    enum :race => { "human"=>0, "gnome"=>1, "dwarf"=>2, "night_elf"=>3, "draenei"=>4,
     "orc"=>5, "troll"=>6, "undead"=>7, "tauren"=>8, "blood_elf"=>9}
    enum :gender => { "male"=>0, "female"=>1}
    enum :character_class => { "paladin"=>0, "warrior"=>1, "hunter"=>2, "rogue"=>3,
     "priest"=>4, "shaman"=>5, "mage"=>6, "warlock"=>7, "druid"=>8, "death_knight"=>9 }


    def wishlist_items
      wishlist_item_links.map{|ci|  {:id=>ci.item.id, :raid_id=>ci.item.raid_id}}
    end

    def avatar 
      "/races/race_#{race.gsub(" ", "").gsub("_", "")}_#{gender}.jpg"
    end

    def class_icon
      "/classes/classicon_#{character_class.name.gsub(" ", "").gsub("_", "").downcase}.jpg"
    end

    def primary_spec_icon
      "/specs/#{primary_spec.name.gsub(" ", "").gsub("_", "")}#{character_class.name.capitalize.gsub(" ", "").gsub("_", "")}.png"
    end

    def secondary_spec_icon
      "/specs/#{secondary_spec.name.gsub(" ", "").gsub("_", "")}#{character_class.name.capitalize.gsub(" ", "").gsub("_", "")}.png"
    end

    def as_json(options = {})
     out = {}
      [:id, :name, :race, :gender, :user_id, :primary_spec_id, :secondary_spec_id, :character_class_id, :avatar, :class_icon, :primary_spec_icon, :secondary_spec_icon, :wishlist_items].each do |key|
       out[key] = self.send(key)
     end
     out
    end
end
