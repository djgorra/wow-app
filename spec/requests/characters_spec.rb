require 'spec_helper'
require 'rake'


# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/characters", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # Character. As you add validations to Character, be sure to
  # adjust the attributes here as well.

  before(:each) do
    @user = FactoryBot.create(:user)
    post "/api/users/sign_in", {:params=>{:user=>{:email=>@user.email, :password=>@user.password}}}   
    assert_response :success

    @character_class = FactoryBot.create(:character_class)
    @spec = FactoryBot.create(:specialization, {:character_class_id=>@character_class.id})
    @spec2 = FactoryBot.create(:specialization, {:name=>"Fury", :character_class_id=>@character_class.id, :role=>@spec.role, :buffs=>@spec.buffs, :debuffs=>@spec.debuffs})
    @character = FactoryBot.create(:character, {:user_id=>@user.id, :character_class_id=>@character_class.id , :primary_spec_id=>@spec.id, :secondary_spec_id=>@spec2.id})
  end

  let(:valid_attributes) {
    {:name=>"Fozzy", :user_id=>@user.id, :character_class_id=>@character_class.id , :primary_spec_id=>@spec.id, :secondary_spec_id=>@spec2.id}
  }

  let(:invalid_attributes) {
    {:name=>"", :user_id=>@user.id, :character_class_id=>@character_class.id , :primary_spec_id=>@spec.id, :secondary_spec_id=>@spec2.id}
  }

  # describe "GET /index" do
  #   it "renders a successful response" do
  #     get characters_url
  #     expect(response).to be_successful
  #   end
  # end

  # describe "GET /show" do
  #   it "renders a successful response" do
  #     get "/api/characters/#{@character.id}"
  #     expect(response).to be_successful
  #   end
  # end

  # describe "GET /new" do
  #   it "renders a successful response" do
  #     get new_character_url
  #     expect(response).to be_successful
  #   end
  # end

  # describe "GET /edit" do
  #   it "renders a successful response" do
  #     character = Character.create! valid_attributes
  #     get edit_character_url(character)
  #     expect(response).to be_successful
  #   end
  # end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Character" do
        expect {
          post "/api/characters.json", params: { character: valid_attributes }
        }.to change(Character, :count).by(1)
      end

      # it "redirects to the created character" do
      #   post characters_url, params: { character: valid_attributes }
      #   expect(response).to redirect_to(character_url(Character.last))
      # end
    end

    context "with invalid parameters" do
      it "does not create a new Character" do
        expect {
          post "/api/characters.json", params: { character: invalid_attributes }
        }.to change(Character, :count).by(0)
      end

  #     it "renders a successful response (i.e. to display the 'new' template)" do
  #       post characters_url, params: { character: invalid_attributes }
  #       expect(response).to be_successful
  #     end
    end
   end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {:name=>"NewName", :user_id=>@user.id, :character_class_id=>@character_class.id , :primary_spec_id=>@spec.id, :secondary_spec_id=>@spec2.id}
      }

      it "updates the requested character" do
        character = Character.create! valid_attributes
        put "/api/characters/#{character.id}.json", params: { character: new_attributes }
        character.reload
        assert_equal "NewName", character.reload.name
      end

      # it "redirects to the character" do
      #   character = Character.create! valid_attributes
      #   patch character_url(character), params: { character: new_attributes }
      #   character.reload
      #   expect(response).to redirect_to(character_url(character))
      # end
    end

    # context "with invalid parameters" do
    #   it "renders a successful response (i.e. to display the 'edit' template)" do
    #     character = Character.create! valid_attributes
    #     patch character_url(character), params: { character: invalid_attributes }
    #     expect(response).to be_successful
    #   end
    # end
  end

  # describe "DELETE /destroy" do
    it "destroys the requested character" do
      expect {
        delete "/api/characters/#{@character.id}"
      }.to change(Character, :count).by(-1)
    end

  #   it "redirects to the characters list" do
  #     character = Character.create! valid_attributes
  #     delete character_url(character)
  #     expect(response).to redirect_to(characters_url)
  #   end
  #end
end
