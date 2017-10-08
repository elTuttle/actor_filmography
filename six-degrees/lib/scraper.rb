require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_actor_page(actor)
    actor = actor.split(" ")
    actor = actor.join("_")
    actor = actor.downcase
    binding.pry
    actor_url = "https://www.rottentomatoes.com/celebrity/" + actor
    doc = Nokogiri::HTML(open(actor_url))
    #binding.pry
    temp_array = []
    doc.css("#filmographyTbl .unstyled").each do |film|
      temp_array << film.text
    end
    temp_array
  end

  def self.scrape_film_page(film_url)

  end

end


films = Scraper.scrape_actor_page("Johnny Depp")
puts films
