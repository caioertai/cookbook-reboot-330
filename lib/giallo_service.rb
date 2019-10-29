require "open-uri"
require "nokogiri"
require_relative "recipe"

class GialloService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # Build the url with the user input
    url = "https://www.giallozafferano.it/ricerca-ricette/#{@keyword}/"
    # Open the page
    html_page = open(url)
    # Parse the page with Nokogiri
    document = Nokogiri::HTML(html_page)
    # Search the recipe elements on the page
    # doc.search(css_selector) => List of Nokogiri Elements
    # doc.at(css_selector)     => Nokogiri Element
    #   for each element find its name and description
    document.search(".gz-content > .gz-card").first(5).map do |recipe_node|
      name        = recipe_node.at(".gz-title").text.strip
      description = recipe_node.at(".gz-description").text
      Recipe.new(name, description)
    end
  end
end