class ReviewsController < ApplicationController

  get '/reviews/new' do
    if logged_in? && !session[:beer].nil? && !session[:beer].empty?
      erb :'/reviews/new'
    else
      redirect '/login'
    end
  end

  post '/reviews/new' do
    binding.pry
    @beer = session[:beer]
    if params["review"]["look"].empty? || params["review"]["smell"].empty? || params["review"]["taste"].empty? || params["review"]["feel"].empty?
      session[:message] = "Must enter a number for each of the first 4 fields!"
      redirect '/reviews/new'
    else
      @review = Review.create(params["review"])
    end
  end

end
