class DataController < ApplicationController
    # before_action :authenticate_user!
    def datafile
      render :json=>{
        :classes=>CharacterClass.all.as_json,
        :races=>Character.races.map{|r| {:label=>r.first, :value=>r.second}}, 
        :genders=>Character.genders.map{|g| {:label=>g.first, :value=>g.second}}
      }
    end
end