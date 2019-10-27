# VIEW
# The interface between the users and your application
# Responsible for output and input (puts and gets for now) of information
class RecipesView
  def ask_for_name
    puts "What's the recipe name?"
    gets.chomp
  end

  def ask_for_description
    puts "What's the recipe description?"
    gets.chomp
  end

  def ask_for_index
    puts "Which number?"
    gets.chomp.to_i - 1
  end

  def display_recipes(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1}. #{recipe.name} - #{recipe.description}"
    end
  end
end
