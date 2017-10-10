require 'pry'
require_relative "../lib/scraper.rb"
require

class Actor

  attr_reader :name
  attr_accessor :filmography

  @@all = []

  def initialize(name)
    @name = name
    @filmography = Scraper.scrape_actor_page(name)
    @@all << self
  end

  def self.all
    @@all
  end

  def costars
    @filmography.each do |key,value|
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

  def six_degrees(other_actor)
    @filmography.each do |key,value|
      progress_one = ProgressBar.create
      begin
        degree_one = Scraper.scrape_film_page(key, value)
        degree_one.each do |d_one_key, d_one_actors|
          d_one_actors.each do |d_one_actor|
            progress.increment
            if d_one_actor == other_actor
              return "1st degree, #{d_one_key}, #{d_one_actor}"
            end
          end
        end
      rescue OpenURI::HTTPError => ex
      end
    end

    @filmography.each do |key,value|
      begin
        degree_one = Scraper.scrape_film_page(key, value)
        degree_one.each do |d_one_key, d_one_actors|
          d_one_actors.each do |d_one_actor|
            d_one_actor_filmography = Scraper.scrape_actor_page(d_one_actor)
            d_one_actor_filmography.each do |film, film_url|
              begin
                degree_two = Scraper.scrape_film_page(film, film_url)
                degree_two.each do |d_two_key, d_two_actors|
                  d_two_actors.each do |d_two_actor|
                    if d_two_actor == other_actor
                      return "2nd degree, #{@name} => #{d_one_key} => #{d_one_actor} => #{d_two_key} => #{d_two_actor}"
                    end
                  end
                end
              rescue OpenURI::HTTPError => ex
              end
            end
          end
        end
      rescue OpenURI::HTTPError => ex
      end
    end

    @filmography.each do |key,value|
      begin
        degree_one = Scraper.scrape_film_page(key, value)
        degree_one.each do |d_one_key, d_one_actors|
          d_one_actors.each do |d_one_actor|
            puts "#{d_one_actor} D1"
            d_one_actor_filmography = Scraper.scrape_actor_page(d_one_actor)
            d_one_actor_filmography.each do |film, film_url|
              begin
                degree_two = Scraper.scrape_film_page(film, film_url)
                degree_two.each do |d_two_key, d_two_actors|
                  d_two_actors.each do |d_two_actor|
                    puts "#{d_two_actor} D2"
                    d_three_actor_filmography = Scraper.scrape_actor_page(d_two_actor)
                    d_three_actor_filmography.each do |film, film_url|
                    begin
                      degree_three = Scraper.scrape_film_page(film, film_url)
                      degree_three.each do |d_three_key, d_three_actors|
                        d_three_actors.each do |d_three_actor|
                        binding.pry
                          if d_three_actor == other_actor
                            return "3rd degree, #{@name} => #{d_one_key} => #{d_one_actor} => #{d_two_key} => #{d_two_actor} => #{d_three_key} => #{d_three_actor}"
                          end

                        end

                      end

                      rescue OpenURI::HTTPError => ex
                    end
                  end
                end
              end
              rescue OpenURI::HTTPError => ex
            end
          end
        end
      end
      rescue OpenURI::HTTPError => ex
      end
    end

  end

end

ben_kingsley = Actor.new("Ben Kingsley")
binding.pry
#if d_three_actor == other_actor
#  return "2nd degree, #{@name} => #{d_one_key} => #{d_one_actor} => #{d_two_key} => #{d_two_actor}"
#end
