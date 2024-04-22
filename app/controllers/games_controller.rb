require 'open-uri'

class GamesController < ApplicationController
  def new
    # @letters = rand(26).times.map { ("A".."Z").to_a.sample }
    @letters = 10.times.map { ('A'..'Z').to_a.sample }
    @start = Time.now
  end

  def score
    my_word = JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read)

    @letters_in_grid = params[:word].upcase!.chars.all? { |char| params[:word].count(char) <= 10 }
    @score = 0
    if @letters_in_grid
      if my_word['found']
        @score += params[:word].length
      else
        'Not an english word'
      end
    else
      'letters not in grid'
    end
  end
end
