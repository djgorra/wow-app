class Character < ApplicationRecord
    has_many :character_items
    has_many :team_characters
    has_many :teams, through: :team_characters
    has_many :teams, through: :team_code_characters
    has_many :items, through: :character_items
    has_many :character_battles
    has_many :battles, through: :character_battles
    belongs_to :user
    belongs_to :character_class, optional: true
    belongs_to :primary_spec, class_name: "Specialization", foreign_key: "primary_spec_id"
    belongs_to :secondary_spec, class_name: "Specialization", foreign_key: "secondary_spec_id", optional: true
    has_many :wishlist_item_links, -> { where (["assigned = ?", false]) }, :foreign_key => "character_id", :class_name => "CharacterItem"
    # has_many :wishlist_items, :through=>:wishlist_item_links, :class_name=>"Item", :source=>:item
    validates_presence_of :name, :user_id, :character_class_id, :primary_spec_id
    default_scope { where(deleted: false) }
    before_save :set_faction

    enum :race => { "Human"=>0, "Gnome"=>1, "Dwarf"=>2, "Night Elf"=>3, "Draenei"=>4,
     "Orc"=>5, "Troll"=>6, "Undead"=>7, "Tauren"=>8, "Blood Elf"=>9}
    enum :gender => { "Male"=>0, "Female"=>1}
    enum :character_class => { "Paladin"=>0, "Warrior"=>1, "Hunter"=>2, "Rogue"=>3,
     "Priest"=>4, "Shaman"=>5, "Mage"=>6, "Warlock"=>7, "Druid"=>8, "Death Knight"=>9 }
    enum :faction => { "Alliance"=>0, "Horde"=>1}


    def set_faction
      if ["Human", "Gnome", "Dwarf", "Night Elf", "Draenei"].include?(self.race)
        self.Alliance!
      else
        self.Horde!
      end
    end

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

    def primary_spec_role
      primary_spec.role
    end

    def secondary_spec_role
      secondary_spec.role
    end

    def as_json(options = {})
     out = {}
      [:id, :name, :race, :gender, :user_id, :primary_spec_id, :secondary_spec_id, :primary_spec_icon, :secondary_spec_icon, :primary_spec_role, :secondary_spec_role, :character_class_id, :avatar, :class_icon, :wishlist_items, :version_id, :faction].each do |key|
       out[key] = self.send(key)
     end
     out
    end
end
