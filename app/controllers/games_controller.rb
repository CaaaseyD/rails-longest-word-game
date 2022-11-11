require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = [*('A'..'Z')].shuffle[0,10]
  end
  def score
    @letters = JSON.parse(params[:letters])
    @word = params[:word]
    wordArray = @word.upcase.split('')
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    response = URI.open(url).read
    parsed_response = JSON.parse(response)
    if (wordArray - @letters).empty?
      if parsed_response["found"]
        @result = "Congratulations! #{@word} is a valid English word!"
      elsif
        @result = "Sorry but #{@word} does not seem to be a valid English word..."
      end
    else
      @result = "Sorry but #{@word} can't be bulit out of #{@letters.join(",")}"
    end


  end
end
