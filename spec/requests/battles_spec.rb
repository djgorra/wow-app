require 'spec_helper'
require 'rake'

RSpec.describe "/battles", type: :request do

    before(:each) do
        @user = FactoryBot.create(:user)
        post "/api/users/sign_in", {:params=>{:user=>{:email=>@user.email, :password=>@user.password}}}   
        assert_response :success
        @team = FactoryBot.create(:team, {:user_id=>@user.id})
        @character_class = FactoryBot.create(:character_class)
        @spec = FactoryBot.create(:specialization, {:character_class_id=>@character_class.id})
        @spec2 = FactoryBot.create(:specialization, {:name=>"Fury", :character_class_id=>@character_class.id, :role=>@spec.role})
        @character = FactoryBot.create(:character, {:user_id=>@user.id, :character_class_id=>@character_class.id , :primary_spec_id=>@spec.id, :secondary_spec_id=>@spec2.id})
        @raid = FactoryBot.create(:raid)
        @run = FactoryBot.create(:run, {:team_id=>@team.id, :raid_id=>@raid.id})
        @tc = TeamCharacter.create(team_id: @team.id, character_id: @character.id)
        @boss = FactoryBot.create(:boss, {:raid_id=>@raid.id})
        @item = FactoryBot.create(:item, {:boss_id=>@boss.id, :raid_id=>@raid.id})
        
    end
    
    it "creates a battle" do
        expect {
            expect {
                post "/api/battles/", params: { :run_id=>@run.id, :boss_id=>@boss.id }
            }.to change(Battle, :count).by(1)
        }.to change(CharacterBattle, :count).by(@run.team.characters.count)
        @drop = FactoryBot.create(:drop, {:item_id=>@item.id, :character_battle_id=>CharacterBattle.last.id})
        assert !JSON.parse(response.body)["drops"].nil?
        puts response.body

        expect {
            expect {
                post "/api/battles/", params: { :run_id=>@run.id, :boss_id=>@boss.id }
            }.to change(Battle, :count).by(0)
        }.to change(CharacterBattle, :count).by(0) #i.e. do not create new character_battles if battle already exists
    end
    
    it "returns an existing battle" do
        @battle = FactoryBot.create(:battle, {:run_id=>@run.id, :boss_id=>@boss.id})
        get "/api/battles/#{@battle.id}"
        assert_response :success
        assert_equal @battle.id, JSON.parse(response.body)["id"]
    end
end
