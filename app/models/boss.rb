class Boss < ApplicationRecord
    belongs_to :raid, optional: true
    has_many :items

    def self.seed #updates the raid IDs for bosses with no zone ID based on hardcoded values. To be ran after Item.seed
        ulduar_bosses = [4273, ["Flame Leviathan", "Ignis the Furnace Master", "Razorscale", "XT-002 Deconstructor", "Steelbreaker", "Kologarn", "Auriaya", "Hodir", "Thorim", "Freya", "Mimiron", "General Vezax", "Yogg-Saron", "Algalon the Observer"]]
        toc_bosses = [4722, ["Icehowl", "Lord Jaraxxus", "Faction Champions", "Eydis Darkbane", "Anub'arak"]]
        voa_bosses = [4603, ["Archavon the Stone Watcher", "Emalon the Storm Watcher", "Koralon the Flame Watcher", "Toravon the Ice Watcher"]]
        icc_bosses = [4812, ["Lord Marrowgar", "Lady Deathwhisper", "Icecrown Gunship Battle", "Deathbringer Saurfang", "Festergut", "Rotface", "Professor Putricide", "Blood Prince Council", "Blood-Queen Lana'thel", "Valithria Dreamwalker", "Sindragosa", "The Lich King"]]
        ruby_bosses = [4987, ["Halion"]]

        boss_list = [ ulduar_bosses, toc_bosses, voa_bosses, icc_bosses, ruby_bosses ]

        boss_list.each do |arr|
            arr[1].each do |boss|
                if Boss.find_by(name: boss)
                    Boss.find_by(name: boss).update(raid_id: arr[0])
                end
            end
        end

    end
end
