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

  # instance method
  def to_a
    # self => instance
    [name, description, done?]
  end
end
