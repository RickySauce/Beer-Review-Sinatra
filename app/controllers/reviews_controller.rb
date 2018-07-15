class ReviewsController < ApplicationController

  get '/reviews/new' do
    if logged_in? && session[:beer].class == Beer
      if current_user.reviews.any? {|review| review.beer_id == session[:beer].id}
        session[:message] = "You have already reviewed this beer!"
        redirect '/review'
      else
        erb :'/reviews/new'
      end
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
      @review.beer = @beer
      @review.user = current_user
      @review.rating
      @review.save
      @beer.reviews << @review
      @beer.rating
      @beer.save
      @brewery = @beer.brewery
      @brewery.rating
      @brewery.save
      current_user.reviews << @review
      current_user.save
      session[:beer] = ""
      redirect "/reviews/#{@review.id}"
    end
  end

end
