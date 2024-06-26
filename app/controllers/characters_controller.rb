class CharactersController < ApplicationController
  before_action :set_character, only: %i[ show edit update destroy show_drops add_items ]


  def index
    if params[:version_id]
      @characters = current_user.characters.where(version_id: params[:version_id])
    else
      @characters = current_user.characters
    end
    render json: @characters
  end

  def show
    render json: @character
  end

  def show_drops
    render json: @character.drops
  end

  def add_items
    raid = Raid.find(params[:raid_id])
    @character.wishlist_items.each do |item|
      if item[:raid_id].to_s == raid.id.to_s
        #remove character_item
        @character.items.delete(Item.find(item[:id]))
      end
    end

    params[:item_ids].each do |item_id|
      if !@character.items.include?(Item.find(item_id))
        @character.items << Item.find(item_id)
      end
    end
    render json: @character.user.as_json
  end

  # POST /characters or /characters.json
  def create
    if current_user
      @character = Character.new(character_params)

      respond_to do |format|
        if @character.save
          format.html { redirect_to "/api/characters/#{@character.id}", notice: "Character was successfully created." }
          format.json { render :json=>current_user.as_json, status: :created }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render :json=>{:message=>@character.errors.full_messages.first}, status: :unprocessable_entity }
        end
      end
    else
      head :unauthorized
    end
  end

  # PATCH/PUT /characters/1 or /characters/1.json
  def update
    if current_user && @character.user_id == current_user.id
      respond_to do |format|
        if @character.update!(character_params)
          if params[:team_code].present?
            if Team.find_by(invite_code: params[:team_code])
              TeamCodeCharacter.create(team_id: Team.find_by(invite_code: params[:team_code]).id, character_id: @character.id)
            else
              format.json { render json: { message: "Team not found. Please check the invite code and try again." }, status: :not_found }
            end
          end
          format.html { redirect_to "/api/characters/#{@character.id}", notice: "Character was successfully updated." }
          format.json { render :json=>current_user.as_json, status: :created }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @character.errors, status: :unprocessable_entity }
        end
      end
    else
      head :unauthorized
    end
  end

  # DELETE /characters/1 or /characters/1.json
  def destroy
    if current_user && @character.user_id == current_user.id
      @character.deleted = true
      @character.save
      respond_to do |format|
        format.html { redirect_to characters_url, notice: "Character was successfully destroyed." }
        format.json { render json: current_user.as_json }
      end
    else
      head :unauthorized
    end
  end

  def discord_create
    render json: params
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character
      @character = Character.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def character_params
      params.require(:character).permit(:name, :user_id, :character_class_id, :primary_spec_id, :secondary_spec_id, :race, :gender, :version_id)
    end
end
