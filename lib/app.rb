# Modules
require "csv"
require "pry-byebug"

# Repository
require_relative "cookbook"

# Controller
require_relative "controller"

# Router
require_relative "router"

csv_file   = File.join(__dir__, "recipes.csv")
cookbook   = Cookbook.new(csv_file)
controller = Controller.new(cookbook)

router = Router.new(controller)

# Start the app
router.run
