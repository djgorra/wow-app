require 'open-uri'

class Raid < ApplicationRecord
    has_many :bosses
    has_many :items

    def self.seed
        data = open("https://raw.githubusercontent.com/nexus-devs/wow-classic-items/master/data/json/zones.json")
        zones = JSON.parse(data.read)
        zones.each do |zone|
            if zone["category"] == "Raid"
                next if zone["level"] == [nil, nil] # some zones have null values for level
                if zone["level"][1] < 80 && zone["name"] != "Naxxramas" # only include raids that are level 80. Naxxramas is level 60 for some reason
                    next
                end
                if Raid.find_by(wow_id: zone["id"]).nil?
                    Raid.create(wow_id: zone["id"], name: zone["name"])
                end
                raid = Raid.find_by(wow_id: zone["id"])
                if raid.name.blank?
                    raid.update(name: zone["name"])
                end
            end
        end
    end
end
