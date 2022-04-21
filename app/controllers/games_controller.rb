class GamesController < ApplicationController
  require 'rest-client'

  def new
    @letters = ('a'..'z').to_a.shuffle[0..9]
  end

  def score
    @word = params[:word]
    @response = RestClient.get("https://wagon-dictionary.herokuapp.com/#{@word}")
    @json = JSON.parse(@response)
   if @json["found"] == true && @word.include?(@letters.to_s)
      @message = "Congratulations! #{@word} is a valid English word!"
    else
      @message = "Sorry but #{@word} does not seem to be a valid English word..."
    end
  end
end
