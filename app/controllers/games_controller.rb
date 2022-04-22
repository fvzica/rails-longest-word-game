class GamesController < ApplicationController
  require 'rest-client'

  def new
    @letters = ('a'..'z').to_a.shuffle[0..9]
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    @contagem = @word.length == @letters.split.map {|l| @word.include?(l)}.count(true)
    @response = RestClient.get("https://wagon-dictionary.herokuapp.com/#{@word}")
    @json = JSON.parse(@response)
   if @json["found"] == true && @contagem
      @message = "Congratulations! #{@word} is a valid English word!"
   elsif @json["found"] == true && @contagem == false
    @message = "Valid english word, but not in the random letters =( "
   else
      @message = "Sorry but #{@word} does not seem to be a valid English word..."
    end
  end
end
