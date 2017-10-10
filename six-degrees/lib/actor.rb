require 'pry'
require 'ruby-progressbar'
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

  def have_worked_with?(other_actor)
    progress_one = ProgressBar.create(:title => "First seperation", :total => @filmography.length)

    @filmography.each do |key,value|
      progress_one.increment
      begin
        degree_one = Scraper.scrape_film_page(key, value)
        degree_one.each do |d_one_key, d_one_actors|
          d_one_actors.each do |d_one_actor|
            if d_one_actor == other_actor
              return "1st degree, #{d_one_key}, #{d_one_actor}"
            end
          end
        end
      rescue OpenURI::HTTPError => ex
      end
    end
  end

ben_kingsley = Actor.new("Ben Kingsley")
binding.pry
