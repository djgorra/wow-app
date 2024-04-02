require 'spec_helper'
require 'rake'

RSpec.describe "/teams", type: :request do

    before(:each) do
        @version = FactoryBot.create(:version)
        @user = FactoryBot.create(:user)
        post "/api/users/sign_in", {:params=>{:user=>{:email=>@user.email, :password=>@user.password}}}   
        assert_response :success
        current_user = @user
    
        @character_class = FactoryBot.create(:character_class)
        @spec = FactoryBot.create(:specialization, {:character_class_id=>@character_class.id})
        @spec2 = FactoryBot.create(:specialization, {:name=>"Fury", :character_class_id=>@character_class.id, :role=>@spec.role})
        @character = FactoryBot.create(:character, {:user_id=>@user.id, :character_class_id=>@character_class.id , :primary_spec_id=>@spec.id, :secondary_spec_id=>@spec2.id})
        @raid = FactoryBot.create(:raid)
    end

    let(:valid_attributes) {
        {:name=>"Team 1", :user_id=>@user.id, :faction=>"Horde"}
    }

    it "creates a new team with an invite code" do
        expect {
            post "/api/teams", params: { team: valid_attributes }
        }.to change(Team, :count).by(1)
        Team.last.invite_code.should_not be_nil
    end



    it "updates a team" do
        team = FactoryBot.create(:team)
        put "/api/teams/#{team.id}", params: { team: valid_attributes }
        assert_equal "Team 1", team.reload.name
    end

    it "shows a list of teams" do
        get "/api/teams", {params: {:team=>{version_id: @version.id}}}
        assert_response :success
    end

    it "deletes a team" do
        team = FactoryBot.create(:team, {:version_id=>@version.id, :user_id=>@user.id})
        expect {
            delete "/api/teams/#{team.id}", {params: {:team=>{version_id: @version.id}}}
        }.to change(Team, :count).by(-1)
        assert_response :redirect
        follow_redirect!
        assert_response :success
        assert_equal "/api/teams", path
        assert_equal "GET", request.request_method #I was running into an issue where it was trying to redirect to the index with a DELETE method
    end

    it "shows teams from a specific version" do
        version2 = FactoryBot.create(:version)
        team = FactoryBot.create(:team, {:version_id=>@version.id, :user_id=>@user.id})
        team2 = FactoryBot.create(:team, {:version_id=>version2.id, :user_id=>@user.id})
        team_character = FactoryBot.create(:team_character, {:team_id=>team.id, :character_id=>@character.id})
        team_character2 = FactoryBot.create(:team_character, {:team_id=>team2.id, :character_id=>@character.id})
        #create two teams with seperate versions

        get "/api/teams", {params: {:team=>{version_id: @version.id}}}
        assert_response :success
        assert_equal 1, JSON.parse(response.body).length
        assert_equal team.id, JSON.parse(response.body)[0]["id"]
        #expect only the team with the correct version to be returned
    end

    it "adds a character to a team" do
        team = FactoryBot.create(:team)
        expect {
            post "/api/teams/#{team.id}/characters", params: { character_id: @character.id }
        }.to change(team.characters, :count).by(1)
    end

    it "adds a character to a team from an invite code" do
        team = FactoryBot.create(:team)
        expect {
            post "/api/teams/#{team.invite_code}/invite", params: { character_id: @character.id }
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