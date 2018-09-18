class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.all
    @values = Hash.new
    
    @recipes.each do |r|
      
       parts = Part.where( recipe_id: r.id).find_each
       price = 0
       
       parts.each do |p|
        
        ingredient= Ingredient.find(p.ingredient_id)
        price = price + ingredient.cost*p.amount
        
       end
      
      @values[r.id]= price
      
    end
    
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
    
    @part = Part.new
    find_parts
    find_ingredients
    calculate_price
    
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:name)
    end
    
    def find_parts
      
      @parts = Part.where( recipe_id: params[:id]).find_each
      
    end
    
    def calculate_price
      
      @price = 0
      @parts.each do |p|
        
        ingredient= Ingredient.find(p.ingredient_id)
        
        @price = @price + ingredient.cost*p.amount
        
      end
      
    end
      
    
    
    def find_ingredients
      
      @ingredients = Array.new
      Ingredient.all.each do |ing|
        
        pair = Array.new
        
        pair.push(ing.name,ing.id)
        
        @ingredients.push(pair)
        
      end
      
    end
      
end
