require "json"
require "rest-client"

class GamesController < ApplicationController

  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  def score
    word = params[:name].split(//)
    @letters = params[:letters].split
    response = RestClient.get "https://wagon-dictionary.herokuapp.com/#{params[:name]}"
    repos = JSON.parse(response)
    word.each do |element|
      letter = element.upcase
      if @letters.include?(letter) && repos[:found] == true
        @result = "Congratulations! #{params[:name]} is a valid English word!"
      elsif @letters.include?(letter) && repos[:found] == false
        @result = "Sorry but #{params[:name]} does not seem to be a valid English word..."
      else
        @result = "Sorry but #{params[:name]} can't be built out of #{@letters}"
      end
    end
  end
end
