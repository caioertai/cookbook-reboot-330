# REPOSITORY
# It's the layer between your model (recipe) and your database (the csv for now)
# It handles the parsing and storing of data.
class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []

    # Moved the csv loading to the private method #load_csv
    load_csv
  end

  def add_recipe(recipe)
    @recipes << recipe

    # A private method used by both add_recipe and remove_recipe
    update_csv
  end

  def all
    @recipes
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)

    # A private method used by both add_recipe and remove_recipe
    update_csv
  end

  private

  def load_csv
    # Update @recipes (memory) with recipes.csv file
    CSV.foreach(@csv_file_path) do |row|
      name        = row[0]
      description = row[1]
      recipe      = Recipe.new(name, description)
      @recipes << recipe
    end
  end

  def update_csv
    # Update recipes.csv with the current state of @recipes (memory)
    CSV.open(@csv_file_path, "wb") do |csv_file|
      @recipes.each do |recipe|
        csv_file << [recipe.name, recipe.description]
      end
    end
  end
end

