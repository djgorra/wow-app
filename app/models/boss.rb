class Boss < ApplicationRecord
    belongs_to :raid, optional: true
    has_many :items

    def self.seed #updates the raid IDs for bosses with no zone ID based on hardcoded values. To be ran after Item.seed
        naxx_bosses = [Raid.find_by_name("Naxxramas").id, ["Anub'Rekhan", "Grand Widow Faerlina", "Maexxna", "Noth the Plaguebringer", "Heigan the Unclean", "Loatheb", "Instructor Razuvious", "Gothik the Harvester", "The Four Horsemen", "Patchwerk", "Grobbulus", "Gluth", "Thaddius", "Sapphiron", "Kel'Thuzad"]]
        ulduar_bosses = [Raid.find_by_name("Ulduar").id, ["Flame Leviathan", "Ignis the Furnace Master", "Razorscale", "XT-002 Deconstructor", "Steelbreaker", "Kologarn", "Auriaya", "Hodir", "Thorim", "Freya", "Mimiron", "General Vezax", "Yogg-Saron", "Algalon the Observer"]]
        toc_bosses = [Raid.find_by_name("Crusaders' Coliseum: Trial of the Crusader").id, ["Icehowl", "Lord Jaraxxus", "Faction Champions", "Eydis Darkbane", "Anub'arak"]]
        voa_bosses = [Raid.find_by_name("Vault of Archavon").id, ["Archavon the Stone Watcher", "Emalon the Storm Watcher", "Koralon the Flame Watcher", "Toravon the Ice Watcher"]]
        icc_bosses = [Raid.find_by_name("Icecrown Citadel").id, ["Lord Marrowgar", "Lady Deathwhisper", "Icecrown Gunship Battle", "Deathbringer Saurfang", "Festergut", "Rotface", "Professor Putricide", "Blood Prince Council", "Blood-Queen Lana'thel", "Valithria Dreamwalker", "Sindragosa", "The Lich King"]]
        ruby_bosses = [Raid.find_by_name("The Ruby Sanctum").id, ["Halion"]]
        tos_bosses = [Raid.find_by_name("The Obsidian Sanctum").id, ["Nefarian"]]
        eoe_bosses = [Raid.find_by_name("The Eye of Eternity").id, ["Malygos"]]
        ony_bosses = [Raid.find_by_name("Onyxia's Lair").id, ["Onyxia"]]

        boss_list = [ ulduar_bosses, toc_bosses, voa_bosses, icc_bosses, ruby_bosses, naxx_bosses, tos_bosses, eoe_bosses, ony_bosses ]

        boss_list.each do |arr|
            arr[1].each do |boss|
                if Boss.find_by(name: boss)
                    Boss.find_by(name: boss).update(raid_id: arr[0])
                end
            end
        end

    end
end
