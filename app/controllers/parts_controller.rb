class PartsController < ApplicationController
  before_action :set_part, only: [:show, :edit, :update, :destroy]
    
    @ingredients = Array.new
    Ingredient.all.each do |ing|
      
      pair = Array.new
      
      pair.push(ing.name,ing.id)
      
      @ingredients.push(pair)
      
    end

  # GET /parts
  # GET /parts.json
  def index
    @parts = Part.all
  end

  # GET /parts/1
  # GET /parts/1.json
  def show
  end

  # GET /parts/new
  def new
    @part = Part.new
    
    find_ingredients

  end

  # GET /parts/1/edit
  def edit
    find_ingredients
    
  end

  # POST /parts
  # POST /parts.json
  def create
    @part = Part.new(part_params)
    @part.ingredient_id = params[:part][:ingredient]
    
    puts "ATENCION"
    puts params[:part][:ingredient]
    puts "resultado"

    respond_to do |format|
      if @part.save
        
        @rec = Recipe.find(params[:part][:recipe_id])
        format.html { redirect_to recipe_url(@rec), notice: 'Part was successfully created.' }

      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /parts/1
  # PATCH/PUT /parts/1.json
  def update
    respond_to do |format|
      if @part.update(part_params)
        format.html { redirect_to @part, notice: 'Part was successfully updated.' }
        format.json { render :show, status: :ok, location: @part }
      else
        format.html { render :edit }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parts/1
  # DELETE /parts/1.json
  def destroy
    @part.destroy
    respond_to do |format|
        @rec = Recipe.find(@part.recipe_id)
        format.html { redirect_to recipe_url(@rec), notice: 'Part was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_part
      @part = Part.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def part_params
      params.require(:part).permit(:amount, :ingredient_id, :recipe_id)
    end
    
    #Carga lista de ingredientes.
    def find_ingredients
      
      @ingredients = Array.new
      Ingredient.all.each do |ing|
        
        pair = Array.new
        
        pair.push(ing.name,ing.id)
        
        @ingredients.push(pair)
        
      end
      
    end
end
