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
    # We need to update mark recipe from with the repo...
    recipe_to_mark = @recipes[index]
    recipe_to_mark.mark_as_done!

    # ... since the update_csv method is private and only available here.
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

    # Those CSV options (paired with an update of the CSV to user headers)
    # Allow us to get hash for each line of the CSV.
    # The nice thing about this is that a hash is exactly what we need
    # to initialize our Recipe
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      # The CSV is only able to store strings, so when we retrieve the value
      # of "done" we end up with a string "true" or "false" which need to be
      # converted into an ACTUAL boolean (not a string) if we want to app
      # to still work properly, hence the row[:done] == "true".
      row[:done] = row[:done] == "true"
      # With the value being properly treated, we can just sen the row as
      # the argument (since it nows works like a hash).
      recipe = Recipe.new(row)
      @recipes << recipe
    end
  end

  def update_csv
    # Update recipes.csv with the current state of @recipes (memory)
    CSV.open(@csv_file_path, "wb") do |csv_file|
      # Since we're using headers now on our CSV, we need to push this first
      # line, the header, everytime we update the CSV.
      csv_file << ["name", "description", "done"]
      @recipes.each do |recipe|
        # We "taught" our recipe to convert itself to an array
        # Check Recipe#to_a in "recipe.rb"
        csv_file << recipe.to_a
      end
    end
  end
end

