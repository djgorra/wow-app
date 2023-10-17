class DataController < ApplicationController
    # before_action :authenticate_user!
    def datafile
      render :json=>{
        :classes=>CharacterClass.all.as_json,
        :specs=>Specialization.all.as_json,
        :races=>Character.races.map{|r| {:label=>r.first, :value=>r.first}}, 
        :genders=>Character.genders.map{|g| {:label=>g.first, :value=>g.first}},
        :raids => Raid.all.as_json,
        :bosses=>Boss.all.as_json
      }
    end

    def buffs 
      out = []
      effect_types.each do |effect_type|
        out << {:title=>effect_type, :data=> Buff.where(:effect_type=>effect_type).pluck(:name, :id)}
      end
      out
    end
end