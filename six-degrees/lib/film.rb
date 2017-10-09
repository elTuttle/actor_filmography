require 'pry'
require_relative "../lib/scraper.rb"
require_relative "../lib/actor.rb"

class Film

  attr_reader :name, :url
  attr_accessor :actors

  def initialize(name, filmURL)
    @name = name
    @url = filmURL
  end

  def actors(title,url)
    begin
      puts key
      temp_array = Scraper.scrape_film_page(key, value)
      puts temp_array
    rescue OpenURI::HTTPError => ex
      puts "#{key} cannot be found"
      puts ""
    end
  end

end
