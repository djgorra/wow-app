require 'spec_helper'
require 'rake'

# FRIENDS TABLE 
# user_id
# friend_id

# FRIENDLIST
# user_id
# battletag

RSpec.describe "/friends", type: :request do

  before(:each) do
    @bob = FactoryBot.create(:user, :battletag=>"WhiteMist#52")
    post "/api/users/sign_in", {:params=>{:user=>{:email=>@bob.email, :password=>@bob.password}}}   
    assert_response :success
    data = JSON.parse(response.body)
    @token = data["access_token"]

    @user2 = FactoryBot.create(:user, :battletag=>"JazzyJaguar#15")
  end

  describe "FriendList" do

      it "adds a friend" do
        post "/api/friendlist", {:params=>{:friend=>{:battletag=>"JazzyJaguar#15"}}}
        assert @bob.friends.include?(@user2)
        assert @user2.friends.include?(@bob)
      end
      it "adds a friend who hasn't signed up yet" do
        post "/api/friendlist", {:params=>{:friend=>{:battletag=>"NiceBest#1557"}}}
        delete "/api/users/sign_out.json", headers: { "Authorization" => "Bearer #{@token}" } #i.e. logout

        @jill = FactoryBot.create(:user)
        #i.e. log in as Jill
        post "/api/users/sign_in", {:params=>{:user=>{:email=>@bob.email, :password=>@bob.password}}}   
        #i.e. connect Battletag account
        get "/oauth2/callback", {:params=>{:state=>@jill.email, :code=>rand(18)}}
        assert_response :success

        assert @bob.friends.include?(@jill)
        assert @jill.friends.include?(@bob)

      end
      it "removes a friend" do
        @bob.friends = [@user2]
        delete "/api/friendlist", {:params=>{:friend=>{:battletag=>@user2.battletag}}}
        assert !@bob.friends.include?(@user2)
        assert !@user2.friends.include?(@bob)

      end
  end
end
