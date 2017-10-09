require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_actor_page(actor)
    actor = actor.split(" ")
    actor = actor.join("_")
    actor = actor.downcase

    actor_url = "https://www.rottentomatoes.com/celebrity/" + actor
    doc = Nokogiri::HTML(open(actor_url))
    temp_array = {}

    doc.css("#filmographyTbl .unstyled").each do |film|
      url_string = film.attribute("href").value
      temp_array[film.text] = url_string
    end

    temp_array
  end

  def self.scrape_film_page(film,film_url)
    film_url = "https://www.rottentomatoes.com" + film_url
    doc = Nokogiri::HTML(open(film_url))

    temp_array = {}
    temp_array[film] = []

    doc.css(".castSection .unstyled span").each do |actor|
      actor_name = actor.text
      actor_name = actor_name.split(" ")
      actor_name = actor_name.join(" ")
      temp_array[film] << actor_name
    end
    temp_array
  end

end

Scraper.scrape_actor_page("Johnny Depp")
