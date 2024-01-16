require 'spec_helper'
require 'rake'

RSpec.describe "/runs", type: :request do

    before(:each) do
        @user = FactoryBot.create(:user)
        post "/api/users/sign_in", {:params=>{:user=>{:email=>@user.email, :password=>@user.password}}}   
        assert_response :success
        #signs in

        @character_class = FactoryBot.create(:character_class)
        @spec = FactoryBot.create(:specialization, {:character_class_id=>@character_class.id})
        @spec2 = FactoryBot.create(:specialization, {:name=>"Fury", :character_class_id=>@character_class.id, :role=>@spec.role})
        @team = FactoryBot.create(:team, {:user_id=>@user.id})
        @character = FactoryBot.create(:character, {:user_id=>@user.id, :character_class_id=>@character_class.id , :primary_spec_id=>@spec.id, :secondary_spec_id=>@spec2.id})
        @team_character = FactoryBot.create(:team_character, {:team_id=>@team.id, :character_id=>@character.id})
        @raid = FactoryBot.create(:raid)
        @boss = FactoryBot.create(:boss, {:raid_id=>@raid.id, :name=>"Boss1"})
        @run = FactoryBot.create(:run, {:team_id=>@team.id, :raid_id=>@raid.id})
    end

    let(:valid_attributes) {
        {:team_id=>@team.id, :raid_id=>@raid.id}
    }

    it "creates a new run" do
        expect {
            post "/api/teams/#{@team.id}/runs", params: valid_attributes
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
        assert_equal @team.id, JSON.parse(response.body)[0]["team_id"]
        assert_equal @raid.id, JSON.parse(response.body)[0]["raid_id"]

    end

    it "shows a particular run" do
        run = FactoryBot.create(:run, {:team_id=>@team.id, :raid_id=>@raid.id})
        battle = FactoryBot.create(:battle, {:run_id=>run.id, :boss_id=>@boss.id})
        character_battle = FactoryBot.create(:character_battle, {:character_id=>@character.id, :battle_id=>battle.id})

        get "/api/teams/#{run.team_id}/runs/#{run.id}"
        assert_response :success
        assert_equal run.team_id, JSON.parse(response.body)["team_id"]
        assert_equal run.raid_id, JSON.parse(response.body)["raid_id"]
    end

    it "shows a summary of a run" do
        run = FactoryBot.create(:run, {:team_id=>@team.id, :raid_id=>@raid.id})
        battle = FactoryBot.create(:battle, {:run_id=>run.id, :boss_id=>@boss.id})
        character_battle = FactoryBot.create(:character_battle, {:character_id=>@character.id, :battle_id=>battle.id})
        item = FactoryBot.create(:item, {:boss_id=>@boss.id, :raid_id=>@raid.id})
        drop = FactoryBot.create(:drop, {:character_battle_id=>character_battle.id, :item_id=>item.id})

        get "/api/teams/#{run.team_id}/runs/#{run.id}/summary"
        assert_response :success
    end

    # it "shows drops for a run" do
    #     run = FactoryBot.create(:run)
    #     boss = FactoryBot.create(:boss)
    #     battle = FactoryBot.create(:battle, {:run_id=>run.id, :boss_id=>boss.id})
    #     char_battle = FactoryBot.create(:character_battle, {:battle_id=>battle.id, :character_id=>@character.id})
    #     item = FactoryBot.create(:item)
    #     drop = FactoryBot.create(:drop, {:character_battle_id=>char_battle.id, :item_id=>item.id})
    #     get "/api/teams/#{run.team_id}/runs/#{run.id}/drops"
    #     assert_response :success
    #     assert_equal item.id, JSON.parse(response.body)[0]["item_id"]
    # end
end