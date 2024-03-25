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
    @spec2 = FactoryBot.create(:specialization, {:name=>"Fury", :character_class_id=>@character_class.id, :role=>@spec.role})
    @character = FactoryBot.create(:character, {:user_id=>@user.id, :character_class_id=>@character_class.id , :primary_spec_id=>@spec.id, :secondary_spec_id=>@spec2.id})
    @raid = FactoryBot.create(:raid)
    @team = FactoryBot.create(:team, {:user_id=>@user.id})
  end

  let(:valid_attributes) {
    {:name=>"Fozzy", :user_id=>@user.id, :character_class_id=>@character_class.id , :primary_spec_id=>@spec.id, :secondary_spec_id=>@spec2.id, :race=>"human", :gender=>"male"}
  }

  let(:invalid_attributes) {
    {:name=>"", :user_id=>@user.id, :character_class_id=>@character_class.id , :primary_spec_id=>@spec.id, :secondary_spec_id=>@spec2.id, :race=>"human", :gender=>"male"}
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

  describe "POST /add_item" do
    context "with valid parameters" do
      it "adds an item to the character" do
        item = FactoryBot.create(:item)
        item2 = FactoryBot.create(:item)
        expect {
          post "/api/characters/#{@character.id}/items.json", params: { item_ids: [item.id, item2.id], raid_id: @raid.id }
        }.to change(CharacterItem, :count).by(2)
      end
    end

    it "does not add an item to the character if it already exists" do
      item = FactoryBot.create(:item)
      FactoryBot.create(:character_item, {:character_id=>@character.id, :item_id=>item.id})
      expect {
      post "/api/characters/#{@character.id}/items.json", params: { item_ids: [item.id], raid_id: @raid.id }
      }.to change(CharacterItem, :count).by(0)
    end

    it "deletes all other items from a raid" do
      #i.e. adds 3 items to character wishlist. makes a request to add just the first item to wishlist. should delete the other 2
      item = FactoryBot.create(:item, {:raid_id=>@raid.id})
      item2 = FactoryBot.create(:item, {:raid_id=>@raid.id})
      item3 = FactoryBot.create(:item, {:raid_id=>@raid.id})
      FactoryBot.create(:character_item, {:character_id=>@character.id, :item_id=>item.id})
      FactoryBot.create(:character_item, {:character_id=>@character.id, :item_id=>item2.id})
      FactoryBot.create(:character_item, {:character_id=>@character.id, :item_id=>item3.id})
      assert_equal 3, @character.items.count
      expect {
      post "/api/characters/#{@character.id}/items.json", params: { item_ids: [item.id], raid_id: @raid.id }
      }.to change(CharacterItem, :count).by(-2)
      assert_equal 1, @character.items.count
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

      it "adds character to team via team code" do
        expect {
          put "/api/characters/#{@character.id}.json", params: { character: new_attributes, team_code: @team.invite_code }
        }.to change(TeamCodeCharacter, :count).by(1)
      end

      it "does not add character to team via team code if team code is invalid" do
        expect {
          put "/api/characters/#{@character.id}.json", params: { character: new_attributes, team_code: "invalid" }
        }.to change(TeamCodeCharacter, :count).by(0)
        expect(response).to have_http_status(:not_found)
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
