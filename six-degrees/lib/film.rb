require 'pry'

class Film

  attr_reader :name, :url
  attr_accessor :actors

  def initialize(name, filmURL)
    @name = name
    @url = filmURL
  end


end
