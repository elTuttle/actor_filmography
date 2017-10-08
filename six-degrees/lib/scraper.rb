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

    temp_array = []

    doc.css("#filmographyTbl .unstyled").each do |film|
      temp_array << film.text
    end

    temp_array
  end

  def self.scrape_film_page(film_url)
    doc = Nokogiri::HTML(open(film_url))

    temp_array = []

    doc.css(".castSection .unstyled span").each do |actor|
      actor_name = actor.text
      actor_name = actor_name.split(" ")
      actor_name = actor_name.join(" ")
      temp_array << actor_name
    end
    temp_array
  end

end


films = Scraper.scrape_actor_page("Johnny Depp")
actors = Scraper.scrape_film_page("https://www.rottentomatoes.com/m/blade_runner_2049")

puts actors
