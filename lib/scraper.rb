require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_actor_page(actor_name, actor)
    begin
    actor_name = actor_name.split(" ")
    actor_name = actor_name.join("_")
    actor_name = actor_name.downcase

    actor_url = "https://www.rottentomatoes.com/celebrity/" + actor_name

    doc = Nokogiri::HTML(open(actor_url))

    doc.css("#filmographyTbl .unstyled").each do |film|
      url_string = film.attribute("href").value
      title = film.text
      film_obj = Film.new(title,url_string,actor)
      actor.filmography << film_obj
    end

    temp_array
    rescue OpenURI::HTTPError => ex
      puts "Actor name entered incorrectly or misspelled"
      return nil
    end
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
