class Version < ApplicationRecord

    validates :version_name, presence: true
    validates uniqueness: true

    def self.seed
        Version.create(version_name: "Vanilla")
        Version.create(version_name: "TBC")
        Version.create(version_name: "Wrath")
        Version.create(version_name: "SoD")
    end
end