class DataController < ApplicationController
    # before_action :authenticate_user!
    def datafile
      if params[:version_id]
        raids = Raid.where(version_id: params[:version_id]).as_json
        bosses = Boss.where(version_id: params[:version_id]).as_json
      else
        raids = Raid.all.as_json
        bosses = Boss.all.as_json
      end
      classes = CharacterClass.all.as_json
      specs = Specialization.all.as_json

      render :json=>{
        :classes=>classes,
        :specs=>specs,
        :races=>Character.races.map{|r| {:label=>r.first, :value=>r.first}}, 
        :genders=>Character.genders.map{|g| {:label=>g.first, :value=>g.first}},
        :raids => raids,
        :bosses=>bosses
      }
    end

    def buffs 
      out = []
      effect_types = Buff.pluck(:effect_type).uniq
      effect_types.each do |effect_type|
        out << {:title=>effect_type.titleize, :data=> Buff.where(:effect_type=>effect_type).as_json}
      end
      render json: out
    end
end