# VIEW
# The interface between the users and your application
# Responsible for output and input (puts and gets for now) of information
class RecipesView
  def ask_for(something)
    puts "What's the recipe #{something}?"
    gets.chomp
  end

  def ask_for_index
    puts "Which number?"
    gets.chomp.to_i - 1
  end

  def display_recipes(recipes)
    recipes.each_with_index do |recipe, index|
      x = recipe.done? ? "[X]" : "[ ]"
      puts "#{index + 1}. #{x} #{recipe.name} - #{recipe.description}"
    end
  end
end
