class DataController < ApplicationController
    # before_action :authenticate_user!
    def datafile
      render :json=>{
        :classes=>CharacterClass.all.as_json(:include=> :specializations.as_json),
        :races=>Character.races, 
        :genders=>Character.genders
      }
    end
end