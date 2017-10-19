#require_relative "../lib/scraper.rb"
#require_relative "../lib/actor.rb"
require 'pry'

class CLI

  def get_input
    puts "What is the actors name?"
    actor_input = gets.chomp

    actor_one = Actor.new(actor_input)

    if actor_one.filmography == nil
      get_input
    end

    puts "0 for filmography, 1 for specific info on a film, 2 to see if theyve worked with another actor"

    number_input = gets.chomp
    run_app(number_input,actor_one)
  end

  def run_app(number_input,actor_one)

    if number_input == "0"
      binding.pry
      actor_one.filmography.each do |film|

        puts film.title
      end
    end

    if number_input == "1"
      puts "What film would you like to see?"
      film_input = gets.chomp
      actor_one.filmography.each do |key,value|
        if key == film_input
          film = Scraper.scrape_film_page(key, value)
          film.each do |film_name, actors|
            puts "------------"
            puts film_name
            puts "------------"
            puts actors
          end
        end
      end

    end

    if number_input == "2"
      puts "Which actor would you like to see if they've worked with? (put full name with spaces and capital letters)"
      actor_input = gets.chomp
      actor_one.have_worked_with?(actor_input)
    end

    puts "------------"
    puts "Would you like to ask for more info on this actor, another actor, or end program"
    puts "0 for more info, 1 for new actor, any other key for end program"
    end_input = gets.chomp
    if end_input == "0"
      puts "0 for filmography, 1 for specific info on a film, 2 to see if theyve worked with another actor"
      number_input = gets.chomp
      run_app(number_input, actor_one)
    end

    if end_input == "1"
      get_input
    end

  end
end
