require 'spec_helper'
require 'rake'

RSpec.describe "/drops", type: :request do

    before(:each) do
        user = FactoryBot.create(:user)
        post "/api/users/sign_in", {:params=>{:user=>{:email=>user.email, :password=>user.password}}}   
        assert_response :success
        #signs in

        character_class = FactoryBot.create(:character_class)
        spec = FactoryBot.create(:specialization, {:character_class_id=>character_class.id})
        spec2 = FactoryBot.create(:specialization, {:name=>"Fury", :character_class_id=>character_class.id, :role=>spec.role})
        team = FactoryBot.create(:team, {:user_id=>user.id})
        @character = FactoryBot.create(:character, {:user_id=>user.id, :character_class_id=>character_class.id , :primary_spec_id=>spec.id, :secondary_spec_id=>spec2.id})
        character2 = FactoryBot.create(:character, {:user_id=>user.id, :character_class_id=>character_class.id , :primary_spec_id=>spec.id, :secondary_spec_id=>spec2.id})
        team_character = FactoryBot.create(:team_character, {:team_id=>team.id, :character_id=>@character.id})
        team_character2 = FactoryBot.create(:team_character, {:team_id=>team.id, :character_id=>character2.id})
        @raid = FactoryBot.create(:raid)
        boss = FactoryBot.create(:boss, {:raid_id=>@raid.id, :name=>"Boss1"})
        run = FactoryBot.create(:run, {:team_id=>team.id, :raid_id=>@raid.id})
        @battle = FactoryBot.create(:battle, {:run_id=>run.id, :boss_id=>boss.id})
        @item = FactoryBot.create(:item, {:boss_id=>boss.id, :raid_id=>@raid.id})
        character_battle = FactoryBot.create(:character_battle, {:character_id=>@character.id, :battle_id=>@battle.id})
        character_battle2 = FactoryBot.create(:character_battle, {:character_id=>character2.id, :battle_id=>@battle.id})
        @character.items << @item
        @character.save
        @character.reload
        character_battle.reload
        @battle.reload
        run.reload
        team.reload
        user.reload
    end

    it "returns characters with item in wishlist" do
        get "/api/battles/#{@battle.id}/drops/#{@item.id}"
        assert_response :success
        parsed_response = JSON.parse(response.body)
        assert_equal 1, parsed_response["characters"][0]["data"].count #i.e. there should be one character with the item in their wishlist
        assert_equal 1, parsed_response["characters"][1]["data"].count #i.e. there should be one character without the item in their wishlist
    end

    it "creates a drop and removes it from character's wishlist" do
        assert_equal false, @character.character_items.first.assigned #asserts item in wishlist is not assigned
        assert_equal 1, @character.wishlist_items.count #asserts character has one item in wishlist
        params = {
            battle_id: @battle.id,
            character_id: @battle.characters[0].id,
            item_id: @item.id,
            disenchanted: false
        }
        expect {
            post "/api/battles/#{@battle.id}/drops", :params => params
        }.to change(Drop, :count).by(1)
        assert_response :success
        assert_equal true, @character.character_items.first.assigned #asserts item in wishlist is assigned after drop is created
        assert_equal 0, @character.reload.wishlist_items.count #asserts character has no items in wishlist after drop is created
        get "/api/battles/#{@battle.id}"
        assert @battle.drops.present?
    end
end