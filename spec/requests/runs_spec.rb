require 'spec_helper'
require 'rake'

RSpec.describe "/runs", type: :request do

    before(:each) do
        @user = FactoryBot.create(:user)
        post "/api/users/sign_in", {:params=>{:user=>{:email=>@user.email, :password=>@user.password}}}   
        assert_response :success
    
        @team = FactoryBot.create(:team, {:user_id=>@user.id})
        @character_class = FactoryBot.create(:character_class)
        @spec = FactoryBot.create(:specialization, {:character_class_id=>@character_class.id})
        @spec2 = FactoryBot.create(:specialization, {:name=>"Fury", :character_class_id=>@character_class.id, :role=>@spec.role, :buffs=>@spec.buffs, :debuffs=>@spec.debuffs})
        @character = FactoryBot.create(:character, {:user_id=>@user.id, :character_class_id=>@character_class.id , :primary_spec_id=>@spec.id, :secondary_spec_id=>@spec2.id})
        @raid = FactoryBot.create(:raid)
    end

    let(:valid_attributes) {
        {:team_id=>@team.id, :raid_id=>@raid.id}
    }

    it "creates a new run" do
        expect {
            post "/api/teams/#{@team.id}/runs", params: { run: valid_attributes }
        }.to change(Run, :count).by(1)
    end

    # it "updates a run" do
    #     run = FactoryBot.create(:run)
    #     put "/api/teams/#{@team.id}/runs/#{run.id}", params: { run: valid_attributes }
    #     assert_equal @team.id, run.reload.team_id
    # end

    it "shows a list of runs" do
        get "/api/teams/#{@team.id}/runs"
        assert_response :success
    end

    it "shows a particular run" do
        run = FactoryBot.create(:run)
        get "/api/teams/#{run.team_id}/runs/#{run.id}"
        assert_response :success
    end

    it "shows drops for a run" do
        run = FactoryBot.create(:run)
        boss = FactoryBot.create(:boss)
        battle = FactoryBot.create(:battle, {:run_id=>run.id, :boss_id=>boss.id})
        char_battle = FactoryBot.create(:character_battle, {:battle_id=>battle.id, :character_id=>@character.id})
        item = FactoryBot.create(:item)
        drop = FactoryBot.create(:drop, {:character_battle_id=>char_battle.id, :item_id=>item.id})
        binding.irb
        get "/api/teams/#{run.team_id}/runs/#{run.id}/drops"
        assert_response :success
    end

end