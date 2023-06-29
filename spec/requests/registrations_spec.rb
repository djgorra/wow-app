require 'spec_helper'
require 'rake'

describe Login::RegistrationsController, :type=>:request do


  it "allows login" do
    post "/api/users", {:params=>{:user=>{:email=>"test@test2.com", :password=>"123456", :username=>"Bob"}}}
    assert_response :success
    data = JSON.parse(response.body)
  end
  
  it "allows login" do
    post "/api/users", {:params=>{:user=>{:email=>"test@test2.com", :password=>"123", :username=>"Bob"}}}
    assert_response :success
    data = JSON.parse(response.body)
  end
  
protected


end