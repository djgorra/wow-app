require 'spec_helper'
require 'rake'

RSpec.describe "/teams", type: :request do

    before(:each) do
        @user = FactoryBot.create(:user)
        post "/api/users/sign_in", {:params=>{:user=>{:email=>@user.email, :password=>@user.password}}}   
        assert_response :success
    
        @character_class = FactoryBot.create(:character_class)
        @spec = FactoryBot.create(:specialization, {:character_class_id=>@character_class.id})
        @spec2 = FactoryBot.create(:specialization, {:name=>"Fury", :character_class_id=>@character_class.id, :role=>@spec.role})
        @character = FactoryBot.create(:character, {:user_id=>@user.id, :character_class_id=>@character_class.id , :primary_spec_id=>@spec.id, :secondary_spec_id=>@spec2.id})
        @raid = FactoryBot.create(:raid)
    end

    let(:valid_attributes) {
        {:name=>"Team 1", :user_id=>@user.id}
    }

    it "creates a new team" do
        expect {
            post "/api/teams", params: { team: valid_attributes }
        }.to change(Team, :count).by(1)
    end

    it "updates a team" do
        team = FactoryBot.create(:team)
        put "/api/teams/#{team.id}", params: { team: valid_attributes }
        assert_equal "Team 1", team.reload.name
    end

    it "shows a list of teams" do
        get "/api/teams"
        assert_response :success
    end

    it "adds a character to a team" do
        team = FactoryBot.create(:team)
        expect {
            post "/api/teams/#{team.id}/characters", params: { character_id: @character.id }
        }.to change(team.characters, :count).by(1)

    end

    it "removes a character from a team" do
        team = FactoryBot.create(:team)
        tc = FactoryBot.create(:team_character, {:team_id=>team.id, :character_id=>@character.id})
        expect {
            delete "/api/teams/#{team.id}/characters", params: { character_id: @character.id}
        }.to change(team.characters, :count).by(-1)        
    end

end