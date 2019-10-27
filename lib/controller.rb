require_relative "recipe"
require_relative "recipes_view"

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
    name = @view.ask_for_name
    # 2. Ask the view for a desciption
    description = @view.ask_for_description
    # 3. Initialize the recipe
    recipe = Recipe.new(name, description)
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