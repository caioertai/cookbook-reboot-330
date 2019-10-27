# MODEL
# The main data structure of your application.
# Represents its domains (what it is about).
# A library app has Book, AirBnB has Flat, a hospital could have Patient,
# Doctor, Room and etc...
class Recipe
  attr_reader :name, :description

  # Remember that attr_reader is a shortcut for the following kind of method
  # def name
  #   @name
  # end

  def initialize(name, description)
    @name        = name
    @description = description
  end
end
