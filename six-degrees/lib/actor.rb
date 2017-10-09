require 'pry'
require_relative "../lib/scraper.rb"

class Actor

  attr_reader :name
  attr_accessor :filmography

  def initialize(name)
    @name = name
    @filmography = Scraper.scrape_actor_page(name)
  end

  def costars
    @filmography.each do |key,value|
      begin
        puts key
        temp_array = Scraper.scrape_film_page(value)
        puts temp_array
      rescue OpenURI::HTTPError => ex
        puts "URL cannot be found"
      end
    end
  end
  
end

johnny_depp = Actor.new("Johnny Depp")
binding.pry

