require 'spec_helper'
require 'rake'

describe Users::SessionsController, :type=>:request do


  it "allows login" do
    @user = FactoryBot.create(:user, {:email=>"test@test.com", :password=>"123456", :password_confirmation=>"123456", :username=>"Bob"})
    post "/api/users/sign_in", {:params=>{:user=>{:email=>"test@test.com", :password=>"123456"}}}
    assert_response :success
    data = JSON.parse(response.body)
    assert data["access_token"]
  end 

  it "creates an error message with incorrect login" do
    @user = FactoryBot.create(:user, {:email=>"test@test.com", :password=>"123456", :password_confirmation=>"123456", :username=>"Bob"})
    post "/api/users/sign_in", {:params=>{:user=>{:email=>"test@test.com", :password=>"5555"}}}
    assert_response :unauthorized
    assert response.body.include?("Invalid Email or password")
  end 

  
protected


end