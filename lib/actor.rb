require 'pry'
require 'ruby-progressbar'
require_relative "../lib/scraper.rb"

class Actor

  attr_reader :name
  attr_accessor :filmography

  @@all = []

  def initialize(name)
    @name = name
    @filmography = []
    Scraper.scrape_actor_page(name, self)
    @@all << self
  end

  def self.all
    @@all
  end

  def costars
    progress = ProgressBar.create(:title => "Processing through filmography", :total => @filmography.length)
    @filmography.each do |film|
      progress.increment
      begin
        puts film.title
        temp_array = Scraper.scrape_film_page(film.title, film.url)
        puts temp_array
      rescue OpenURI::HTTPError => ex
        puts "#{key} cannot be found"
        puts ""
      end
    end
  end

  def have_worked_with?(other_actor)
    progress = ProgressBar.create(:title => " Processing through filmography", :total => @filmography.length)
    havent_worked_with = true
    @filmography.each do |film|
      progress.increment
      begin
        degree_one = Scraper.scrape_film_page(film.title, film.url)
        degree_one.each do |d_one_key, d_one_actors|
          d_one_actors.each do |d_one_actor|
            if d_one_actor == other_actor
              havent_worked_with = false
              puts " "
              puts "                              #{@name} worked with #{other_actor} in #{d_one_key}"
            end
          end
        end
      rescue OpenURI::HTTPError => ex
      end
    end
    if havent_worked_with
      puts "#{@name} hasn't worked with #{other_actor}, or actor's name was entered incorrectly"
    end
  end

end
