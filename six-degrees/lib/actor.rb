require 'pry'
require_relative "../lib/scraper.rb"

class Actor

  attr_reader :name
  attr_accessor :filmography

  def initialize(name)
    @name = name
    @filmography = Scraper.scrape_actor_page(name)
  end

end

johnny_depp = Actor.new("Johnny Depp")
binding.pry
