class Version < ApplicationRecord

    def self.seed
        Version.create(version_name: "Vanilla")
        Version.create(version_name: "TBC")
        Version.create(version_name: "Wrath")
    end
end