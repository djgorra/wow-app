require 'spec_helper'
require 'rake'

describe Login::SessionsController, :type=>:request do


  it "allows login" do
    @user = FactoryBot.create(:user, {:email=>"test@test.com", :password=>"123456", :password_confirmation=>"123456", :username=>"Bob"})
    post "/api/users/sign_in", {:params=>{:user=>{:email=>"test@test.com", :password=>"123456"}}}
    assert_response :success
    data = JSON.parse(response.body)
    assert data["access_token"]
  end 

  it "allows registration" do
    @user = FactoryBot.create(:user, {:email=>"test2@test.com", :password=>"123456", :password_confirmation=>"123456", :username=>"Bob"})
    post "/api/users/", {:params=>{:user=>{:email=>"test@test.com", :username=>"user123", :password=>"123456"}}}
    assert_response :success
    data = JSON.parse(response.body)
    assert data["access_token"]
  end 

  it "creates an error message with incorrect login" do
    @user = FactoryBot.create(:user, {:email=>"test@test.com", :password=>"123456", :password_confirmation=>"123456", :username=>"Bob"})
    post "/api/users/sign_in", {:params=>{:user=>{:email=>"test@test.com", :password=>"5555"}}}
    assert_response :unprocessable_entity
  end 

  it "logs out" do
    @user = FactoryBot.create(:user, {:email=>"test@test.com", :password=>"123456", :password_confirmation=>"123456", :username=>"Bob"})
    post "/api/users/sign_in", {:params=>{:user=>{:email=>"test@test.com", :password=>"123456"}}}
    data = JSON.parse(response.body)
    token = data["access_token"]
    expect{
    delete "/api/users/sign_out.json", headers: { "Authorization" => "Bearer #{token}" }
    }.to change(JwtDenylist, :count).by(1)
    assert_response :success
  end
  
protected


end