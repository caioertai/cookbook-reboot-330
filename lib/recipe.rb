# MODEL
# The main data structure of your application.
# Represents its domains (what it is about).
# A library app has Book, AirBnB has Flat, a hospital could have Patient,
# Doctor, Room and etc...
class Recipe
  attr_reader :name, :description

  def initialize(params = {})
    @name        = params[:name]
    @description = params[:description]
    @done        = params[:done] || false
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end

  # Cool instance method that describes how a recipe instance converts
  # itself into an array.
  def to_a
    # This is an instance method. So in here "self" is the instance itself.
    # self => instance

    # So to build the array inside here we can do this:
    # [self.name, self.description, self.done?]

    # BUT! the self would here be redundant since, if you can a method
    # without an object, Ruby automatically calls it on self.
    # So we can end up with this:
    # name        is calling the attr_read :name
    # description is calling the attr_read :description
    # done?       is calling the #done? method we defined
    # It's better to rely on those interface methods than on instance variables.
    [name, description, done?]
  end
end
