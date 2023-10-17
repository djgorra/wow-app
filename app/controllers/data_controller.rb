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
        render json: {
            buffs: Buff.buffs,
            external_buffs: Buff.external_buffs,
            damage_reductions: Buff.damage_reductions,
            debuffs: Buff.debuffs,
            mana_regeneration: Buff.mana_regeneration,
            health_regeneration: Buff.health_regeneration
        }
    end
end