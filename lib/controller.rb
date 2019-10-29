require "pry-byebug"
require_relative "recipe"
require_relative "recipes_view"
require_relative "giallo_service"

# CONTROLLER
# The brains of the operation. Handles the processes behind the user actions.
# We call methods in a controller simply actions for this reason.
# It's the most connected piece of our software and should be handling tasks
# more than actually executing then itself.
class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = RecipesView.new
  end

  def mark_as_done
    # Ask the cookbook for the recipes
    recipes = @cookbook.all
    # Ask view to display recipes
    @view.display_recipes(recipes)
    # Ask for an index
    index = @view.ask_for_index
    # Ask cookbook to mark the recipe
    @cookbook.mark_recipe_as_done(index)
  end

  def import
    # Ask the view for a keyword
    keyword = @view.ask_for("ingredient")
    # Call the Giallo service to get the instances from the web
    searched_recipes = GialloService.new(keyword).call
    # Ask the view to display the searched recipes
    @view.display_recipes(searched_recipes)
    # Ask the use for a number (index) to import
    recipe_index = @view.ask_for_index
    # Get the recipe instance to import (by index)
    imported_recipe = searched_recipes[recipe_index]
    # Ask the cookbok to store the recipe instance
    @cookbook.add_recipe(imported_recipe)
  end

  def destroy
    # 1. Ask the cookbook for the recipes
    recipes = @cookbook.all
    # 2. Ask the view to display them
    @view.display_recipes(recipes)
    # 3. Ask the view to prompt the user for and index
    index = @view.ask_for_index
    # 4. Ask the cookbook to remove the recipe by its index
    @cookbook.remove_recipe(index)
  end

  def create
    # 1. Ask the view for a name
    name = @view.ask_for("name")
    # 2. Ask the view for a desciption
    description = @view.ask_for("description")
    # 3. Initialize the recipe
    recipe = Recipe.new(name: name, description: description)
    # 4. Add the recipe to the cookbook
    @cookbook.add_recipe(recipe)
  end

  def list
    # 1. Ask the cookbook for the recipes
    recipes = @cookbook.all
    # 2. Ask the view to display them
    @view.display_recipes(recipes)
  end
end