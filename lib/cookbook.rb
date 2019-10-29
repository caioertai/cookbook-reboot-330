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

  def mark_recipe_as_done(index)
    recipe_to_mark = @recipes[index]
    recipe_to_mark.mark_as_done!

    update_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)

    # A private method used by both add_recipe and remove_recipe
    update_csv
  end

  private

  def load_csv
    # Update @recipes (memory) with recipes.csv file
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:done] = row[:done] == "true"
      recipe = Recipe.new(row)
      @recipes << recipe
    end
  end

  def update_csv
    # Update recipes.csv with the current state of @recipes (memory)
    CSV.open(@csv_file_path, "wb") do |csv_file|
      csv_file << ["name", "description", "done"]
      @recipes.each do |recipe|
        csv_file << recipe.to_a
      end
    end
  end
end

