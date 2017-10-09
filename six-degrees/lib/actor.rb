require 'pry'
require_relative "../lib/scraper.rb"

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
      begin
        puts key
        degree_one = Scraper.scrape_film_page(key, value)
        puts degree_one
        if value.include?(other_actor)
          puts key
        end
      rescue OpenURI::HTTPError => ex
        puts "#{key} cannot be found"
        puts ""
      end
    end  
  end
  
end

ben_kingsley = Actor.new("Ben Kingsley")
binding.pry

