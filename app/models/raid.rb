require 'open-uri'

class Raid < ApplicationRecord
    has_many :bosses
    has_many :items
    before_save :set_version_id

    def set_version_id
        if self.zone_level == 80
            self.version_id = 3
        elsif self.zone_level == 73
            self.version_id = 2
        else
            self.version_id = 1
        end
    end

    def self.seed
        data = open("https://raw.githubusercontent.com/nexus-devs/wow-classic-items/master/data/json/zones.json")
        zones = JSON.parse(data.read)
        zones.each do |zone|
            if zone["category"] == "Raid"
                next if zone["level"] == [nil, nil] # some zones have null values for level
                next if zone["name"] == "Naxxramas" || zone["name"] == "Onyxia's Lair" # these will be created later for both versions
                if Raid.find_by(wow_id: zone["id"]).nil?
                    Raid.create(wow_id: zone["id"], name: zone["name"], zone_level: zone["level"][1])
                end
                raid = Raid.find_by(wow_id: zone["id"])
                if raid.name.blank?
                    raid.update(name: zone["name"])
                end
                if raid.zone_level.blank? && raid.name != "Naxxramas"
                    raid.update(zone_level: zone["level"][1])
                end
            end
        end
        if naxx = Raid.find_by(name: "Naxxramas", zone_level: nil)
            naxx.update(zone_level: 80)
        end
        #Create Naxxramas for wrath and classic if they don't exist yet
        Raid.create(wow_id: 3456, name: "Naxxramas", zone_level: 80, version_id: 3) if Raid.where(name: "Naxxramas", zone_level: 80).empty?
        Raid.create(wow_id: 3456, name: "Naxxramas", zone_level: 60, version_id: 1) if Raid.where(name: "Naxxramas", zone_level: 60).empty?

        #Create Onyxia's Lair for wrath and classic if they don't exist yet
        Raid.create(wow_id: 2159, name: "Onyxia's Lair", zone_level: 80, version_id: 3) if Raid.where(name: "Onyxia's Lair", zone_level: 80).empty?
        Raid.create(wow_id: 2159, name: "Onyxia's Lair", zone_level: 60, version_id: 1) if Raid.where(name: "Onyxia's Lair", zone_level: 60).empty?
    end
    
end
