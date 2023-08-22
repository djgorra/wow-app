class CharactersController < ApplicationController
  before_action :set_character, only: %i[ show edit update destroy ]


  def index
    @characters = current_user.characters
    render json: @characters
  end

  def show
    @character = Character.find(params[:id])
    render json: @character
  end

  def add_items
    character = Character.find(params[:id])
    params[:item_ids].each do |item_id|
      character.items << Item.find(item_id)
    end
    render json: character.user.as_json
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
      @character.destroy

      respond_to do |format|
        format.html { redirect_to characters_url, notice: "Character was successfully destroyed." }
        format.json { render json: :current_user.as_json }
      end
    else
      head :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character
      @character = Character.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def character_params
      params.require(:character).permit(:name, :user_id, :character_class_id, :primary_spec_id, :secondary_spec_id, :race, :gender)
    end
end
