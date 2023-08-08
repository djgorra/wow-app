class DataController < ApplicationController
    before_action :authenticate_user!
    def datafile
      render :json=>{:classes=>CharacterClass.all.as_json, :specs=>Specialization.all.as_json,:raids=>Raid.all.as_json, :items=>Item.all.as_json, :races=>Character.races, :genders=>Character.genders, :character_classes=>Character.character_classes}
    end
end