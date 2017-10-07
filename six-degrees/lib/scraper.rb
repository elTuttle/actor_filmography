require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_actor_page(actor_url)
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


ben_kingsley_films = Scraper.scrape_actor_page("https://www.rottentomatoes.com/celebrity/ben_kingsley")
puts ben_kingsley_films
