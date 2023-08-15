require 'spec_helper'
require 'rake'

describe OauthController, :type=>:request do

    #SCENARIO 1: Already logged in with email/password, then, connect to Battle.net account
    #RESULT: battletag is added to the pre-existing user
    it "connects a battletag with a pre-existing user" do
        @user = FactoryBot.create(:user)
        get "/oauth2/callback", {:params=>{:state=>@user.email, :code=>rand(18)}}
        assert_response :success
        @user.reload
        #i.e. check battletag was added to pre-existing user
        assert_equal @user.battletag, "NiceBest#1557"
    end

    #SCENARIO 2: Log in with new Battle.net account WIHOUT email/password
    #RESULT: Creates a new user with battletag and blank email and password
    it "creates a new user if connecting without email/password" do
      uuid = SecureRandom.uuid
      expect{
        get "/oauth2/callback", {:params=>{:state=>uuid, :code=>rand(18)}}
        assert_response :success
      }.to change(User, :count).by(1)

      #i.e. check the user that was just created
      @user = User.last
      assert_equal @user.uuid, uuid
      assert_equal @user.battletag, "NiceBest#1557"
      assert @user.email.blank?      
      assert @user.password.blank?

      #i.e. now try to log in as that user
      post "/api/users/uuid", {:params=>{:uuid=>uuid}}
      assert_response :success
      data = JSON.parse(response.body)
      assert data["access_token"]
    end 

    #SCENARIO 3: Log in with pre-existing Battle.net account with or without email/password
    #RESULT: only updates UUID
    it "updates UUID of pre-existing user" do
      uuid = SecureRandom.uuid
      @user = FactoryBot.create(:user, {:battletag=>"NiceBest#1557", :email=>"", :password=>""})
      get "/oauth2/callback", {:params=>{:state=>uuid, :code=>rand(18)}}
      assert_response :success
      @user.reload
      #i.e. check battletag was added to pre-existing user
      assert_equal @user.uuid, uuid
  end



end 