require 'spec_helper'
require 'rake'

describe DataController, :type=>:request do
    before(:each) do
      @user = FactoryBot.create(:user)
      post "/api/users/sign_in", {:params=>{:user=>{:email=>@user.email, :password=>@user.password}}}   
      data = JSON.parse(response.body)
      @token = data["access_token"]

      @character_class = FactoryBot.create(:character_class)
      @spec = FactoryBot.create(:specialization, {:character_class_id=>@character_class.id})
      @spec2 = FactoryBot.create(:specialization, {:name=>"Fury", :character_class_id=>@character_class.id, :role=>@spec.role, :buffs=>@spec.buffs, :debuffs=>@spec.debuffs})
      @character = FactoryBot.create(:character, {:user_id=>@user.id, :character_class_id=>@character_class.id , :primary_spec_id=>@spec.id, :secondary_spec_id=>@spec2.id})
      @raid = FactoryBot.create(:raid)
      @item = FactoryBot.create(:item, {:raid_id=>@raid.id})
    end
    it "gets class and raid data" do
      post "/api/datafile", { :params=>{}, headers: { "HTTP_AUTHORIZATION" =>"Bearer #{@token}" }}
      puts response.body
      assert_response :success
    end

end 