require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_actor_page(actor_url)
    doc = Nokogiri::HTML(open(actor_url))

  end

  def self.scrape_film_page(film_url)

  end

end


ben_kingsley_films = Scraper.scrape_actor_page("https://www.rottentomatoes.com/celebrity/ben_kingsley")
