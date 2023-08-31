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
    @user2 = FactoryBot.create(:user, :battletag=>"JazzyJaguar#15")
  end

  describe "Friends" do

      it "adds a friend" do
        post "/api/friendlist", {:params=>{:friend=>{:battletag=>"JazzyJaguar#15"}}}
        assert @bob.friendlist.include?(@user2)
      end
      # it "adds a friend who hasn't signed up yet" do
      #   post "/api/friendlist", {:params=>{:friend=>{:battletag=>"JollyLead#31"}}}
      #   @jill = FactoryBot.create(:user, :battletag=>"JollyLead#31")
      #   assert @bob.friends.include?(@jill)
      #   assert @jill.friends.include?(@bob
      # end
      it "removes a friend" do
        friend = Friend.create(user_id: @bob.id, friend_id: @user2.id)
        delete "/api/friendlist", {:params=>{:friend=>{:battletag=>@user2.battletag}}}
        assert !@bob.friendlist.include?(@user2)
      end
  end
end
