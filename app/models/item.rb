require 'open-uri'


class Item < ApplicationRecord
    belongs_to :raid, optional: true
    belongs_to :boss, optional: true
    has_and_belongs_to_many :characters

    def as_json(options = {})
        out = {}
        [:name, :image_path, :category, :subcategory, :item_level, :boss_id, :raid_id, :wow_id].each do |key|
            out[key] = self.send(key)
        end
        out
    end

    def image_path
        "/items/#{self.image_url}.jpg"
    end

    def self.download_images
        Item.find_each do |item|
            begin
              open("https://wow.zamimg.com/images/wow/icons/large/#{item.image_url}.jpg") do |image|
                File.open("public/items/#{item.image_url}.jpg","wb") do |file|
                    file.write(image.read)
                end
              end
            rescue Net::OpenTimeout
              next
            end
        end
    end

    def self.seed
        data = open("https://raw.githubusercontent.com/nexus-devs/wow-classic-items/master/data/json/data.json")
        items = JSON.parse(data.read)
        items.each do |item|
            if item["itemLevel"] >= 200 && Item.find_by(wow_id: item["itemId"]).nil?
            # i.e. if the item is ilvl 200+ and is not already in the database
                if item["source"].nil?
                    drops = item["tooltip"].select{|hash| hash.values.to_s.include?("Dropped") }
                    if drops.any?
                        name = drops.join.split(":").last.split("\"").first.strip
                        if Boss.find_by(name: name).nil?
                            Boss.create(name: name)
                        end
                        boss = Boss.find_by(name: name)
                        #i.e. if raid and boss are not already in the database, create them

                        Item.create(
                            name: item["name"],
                            wow_id: item["itemId"],
                            boss_id: boss.id,
                            image_url: item["icon"],
                            category: item["class"],
                            subcategory: item["subclass"],
                            item_level: item["itemLevel"]
                        )
                    end
                elsif item["source"]["category"] == "Boss Drop"
                    if raid = Raid.find_by(wow_id: item["source"]["zone"])
                        if Boss.find_by(name: item["source"]["name"]).nil?
                            Boss.create(raid_id: raid.id, name: item["source"]["name"])
                        end
                        boss = Boss.find_by(name: item["source"]["name"])
                        #i.e. if raid and boss are not already in the database, create them

                        Item.create(
                            name: item["name"],
                            wow_id: item["itemId"],
                            boss_id: boss.id,
                            image_url: item["icon"],
                            category: item["class"],
                            subcategory: item["subclass"],
                            item_level: item["itemLevel"]
                        )
                    end

                elsif item["source"]["category"] == "Zone Drop"
                    if raid = Raid.find_by(wow_id: item["source"]["zone"])
                        Item.create(
                            name: item["name"],
                            wow_id: item["itemId"],
                            raid_id: raid.id,
                            image_url: item["icon"],
                            category: item["class"],
                            subcategory: item["subclass"],
                            item_level: item["itemLevel"]
                        )
                    end

                end

            end
        end
    end

end