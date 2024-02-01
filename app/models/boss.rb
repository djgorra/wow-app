class Boss < ApplicationRecord
    belongs_to :raid, optional: true
    has_many :items

    def self.seed #updates the raid IDs for bosses with no zone ID based on hardcoded values. To be ran after Item.seed and Raid.seed
        ulduar_bosses = [Raid.find_by_name("Ulduar").id, ["Flame Leviathan", "Ignis the Furnace Master", "Razorscale", "XT-002 Deconstructor", "Steelbreaker", "Kologarn", "Auriaya", "Hodir", "Thorim", "Freya", "Mimiron", "General Vezax", "Yogg-Saron", "Algalon the Observer"]]
        toc_bosses = [Raid.find_by_name("Crusaders' Coliseum: Trial of the Crusader").id, ["Icehowl", "Lord Jaraxxus", "Faction Champions", "Eydis Darkbane", "Anub'arak"]]
        voa_bosses = [Raid.find_by_name("Vault of Archavon").id, ["Archavon the Stone Watcher", "Emalon the Storm Watcher", "Koralon the Flame Watcher", "Toravon the Ice Watcher"]]
        icc_bosses = [Raid.find_by_name("Icecrown Citadel").id, ["Lord Marrowgar", "Lady Deathwhisper", "Icecrown Gunship Battle", "Deathbringer Saurfang", "Festergut", "Rotface", "Professor Putricide", "Blood Prince Council", "Blood-Queen Lana'thel", "Valithria Dreamwalker", "Sindragosa", "The Lich King"]]
        ruby_bosses = [Raid.find_by_name("The Ruby Sanctum").id, ["Halion"]]
        tos_bosses = [Raid.find_by_name("The Obsidian Sanctum").id, ["Nefarian"]]
        eoe_bosses = [Raid.find_by_name("The Eye of Eternity").id, ["Malygos"]]

        boss_list = [ ulduar_bosses, toc_bosses, voa_bosses, icc_bosses, ruby_bosses, tos_bosses, eoe_bosses ]

        boss_list.each do |arr|
            arr[1].each do |boss|
                if Boss.find_by(name: boss)
                    Boss.find_by(name: boss).update(raid_id: arr[0])
                end
            end
        end

        naxx_bosses =  ["Anub'Rekhan", "Grand Widow Faerlina", "Maexxna", "Noth the Plaguebringer", "Heigan the Unclean", "Loatheb", "Instructor Razuvious", "Gothik the Harvester", "The Four Horsemen", "Patchwerk", "Grobbulus", "Gluth", "Thaddius", "Sapphiron", "Kel'Thuzad"]
        
        #Naxx bosses should have already been created in Item.seed. This updates the raid ID to the Wrath version of Naxx
        naxx_wrath = Raid.find_by(name: "Naxxramas", version_id:3)
        naxx_bosses.each do |boss|
            if Boss.find_by(name: boss)
                Boss.find_by(name: boss).update(raid_id: naxx_wrath.id)
            end
        end

        #This creates the vanilla version of Naxx bosses and distributes the items to the correct bosses based on item level
        naxx_vanilla = Raid.find_by(name: "Naxxramas", version_id:1)
        naxx_bosses.each do |boss|
            wrath_boss = Boss.find_by(name: boss)
            vanilla_boss = Boss.where(:name => boss, :raid_id => naxx_vanilla.id).first_or_create
            wrath_boss.items.each do |item|
                item.update(boss_id: vanilla_boss.id) if item.item_level < 100
            end
        end

        #This creates the both versions of Onyxia and distributes the items to the correct bosses based on item level
        ony_wrath = Raid.find_by(name: "Onyxia's Lair", version_id:3)
        ony_vanilla = Raid.find_by(name: "Onyxia's Lair", version_id:1)
        ony_boss = Boss.find_by(name: "Onyxia")
        ony_vanilla_boss = Boss.where(:name => "Onyxia", :raid_id => ony_vanilla.id).first_or_create
        ony_boss.items.each do |item|
            item.update(boss_id: ony_vanilla_boss.id) if item.item_level < 100
        end

        #In the data file, items dropped by the boss "The Four Horsemen" are not associated with the boss. This manually corrects that by iterating through the items and updating the boss_id
        horsemen_wrath = naxx_wrath.bosses.find_by(name: "The Four Horsemen")
        horsemen_vanilla = naxx_vanilla.bosses.find_by(name: "The Four Horsemen")
        horsemen_wrath_drops = ["Chestguard of the Lost Vanquisher", "Chestguard of the Lost Conqueror", "Chestguard of the Lost Protector", "Chestguard of the Lost Vanquisher", "Breastplate of the Lost Protector", "Breastplate of the Lost Vanquisher", "Breastplate of the Lost Conqueror", "Charmed Cierge", "Claymore of Ancient Power", "Gown of Blaumeux", "Pauldrons of Havoc", "Thane's Tainted Greathelm", "Broken Promise", "Final Voyage", "Urn of Lost Memories", "Helm of the Grave", "Mantle of the Corrupted", "Armageddon", "Damnation", "Gloves of Peaceful Death", "Leggings of Voracious Shadows", "Zeliek's Gauntlets"]
        horsemen_vanilla_drops = ["Desecrated Tunic", "Desecrated Breastplate", "Desecrated Robe", "Leggings of Apocalypse", "Soulstring", "Maul of the Redeemed Crusader", "Corrupted Ashbringer", "Seal of the Damned", "Warmth of Forgiveness"]
        horsemen_wrath_drops.each do |drop|
            item = Item.find_by(name: drop)
            item.update(boss_id: horsemen_wrath.id)
        end
        horsemen_vanilla_drops.each do |drop|
            item = Item.find_by(name: drop)
            item.update(boss_id: horsemen_vanilla.id)
        end
    
    end

    def as_json(options = {})
        out = {}
        [:id, :name, :raid_id, :items].each do |key|
            out[key] = self.send(key)
        end
        out
    end
end
