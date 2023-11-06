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
        @battle = FactoryBot.create(:battle, {:run_id=>@run.id, :boss_id=>@boss.id})
    end

    it "creates a battle" do
        expect {
            post "/api/battles/", params: { :run_id=>@run.id, :boss_id=>@boss.id }
        }.to change(CharacterBattle, :count).by(@run.team.characters.count)
        assert !JSON.parse(response.body)["drops"].nil?
        binding.irb
    end

    it "creates a drop" do
        cb = FactoryBot.create(:character_battle, {:battle_id=>@battle.id, :character_id=>@character.id})
        item = FactoryBot.create(:item)
        expect {
            post "/api/battles/#{@battle.id}/create_drop", params: { :character_id=>@character.id, item_id: item.id }
    }.to change(Drop, :count).by(1)
    end
end
