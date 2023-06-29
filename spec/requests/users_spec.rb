require 'spec_helper'
require 'rake'

describe UsersController, :type=>:request do
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
end