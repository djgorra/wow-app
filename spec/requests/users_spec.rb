require 'spec_helper'
require 'rake'

describe UsersController, :type=>:request do

    it "creates a user without a username" do
        expect{
            @user = User.create({:wow_id=>"867374154", :battletag=>"NiceBest#1557", :uuid=>"ac493fb6-5d4b-4874-b707-82f14b625568"})
        }.to change(User, :count).by(1)
        expect{
           @user = User.create({:wow_id=>"867374454", :battletag=>"NiceBest#3337", :uuid=>"ac493fb6-5d4b-4874-b707-82f1423jk25568"})
        }.to change(User, :count).by(1)
    end

    it "updates username" do
        @user = FactoryBot.create(:user, {:email=>"test@test.com", :password=>"123456", :password_confirmation=>"123456", :username=>"Bob"})
        post "/api/users/sign_in", {:params=>{:user=>{:email=>"test@test.com", :password=>"123456"}}}
        assert_response :success
        data = JSON.parse(response.body)
        token = data["access_token"]
        params = {:user=>{:username=>"Ted"}}
        put "/users", { :params=>params, headers: { "HTTP_AUTHORIZATION" =>"Bearer #{token}" }}
        assert_response :success
        assert_equal @user.reload.username, "Ted"
    end

    it "uploads a user avatar" do
        @user = FactoryBot.create(:user)
        post "/api/users/sign_in", {:params=>{:user=>{:email=>@user.email, :password=>@user.password}}}   
        assert_response :success
        data = JSON.parse(response.body)
        token = data["access_token"]     
        test_image = './spec/fixtures/images/avatar.png'
        file = Rack::Test::UploadedFile.new(test_image, "image/png")
        patch "/users", {:params=>{:user=>{:avatar=>file}}, headers: { "HTTP_AUTHORIZATION" =>"Bearer #{token}" }}
        assert_response :success
        assert @user.reload.avatar.present?
      end
end 