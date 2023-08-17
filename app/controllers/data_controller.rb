class DataController < ApplicationController
    # before_action :authenticate_user!
    def datafile
      render :json=>{
        :classes=>CharacterClass.all.as_json,
        :specs=>Specialization.all.as_json,
        :races=>Character.races.map{|r| {:label=>r.first, :value=>r.first}}, 
        :genders=>Character.genders.map{|g| {:label=>g.first, :value=>g.first}},
        :raids => Raid.all.as_json,
        :bosses=>Bosses.all.as_json
      }
    end
end