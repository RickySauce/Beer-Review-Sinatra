class ReviewsController < ApplicationController

  get '/reviews' do
    erb :'/reviews/reviews'
  end

  get '/reviews/:beer_id/new' do
    @beer = Beer.find(params["beer_id"])
    if logged_in? && @beer
      if current_user.reviews.any? {|review| review.beer_id == @beer.id}
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
    @beer = Beer.find_by(name: params["beer"]["name"])
    if params["review"]["look"].empty? || params["review"]["smell"].empty? || params["review"]["taste"].empty? || params["review"]["feel"].empty?
      session[:message] = "Must enter a number for each of the first 4 fields!"
      redirect "/reviews/#{@beer.id}/new"
    else
      @review = Review.create(params["review"])
      @review.beer = @beer
      @review.user = current_user
      @review.save
      @beer.reviews << @review
      @beer.save
      current_user.reviews << @review
      current_user.beers << @beer if !current_user.beers.any? {|beer| beer == @beer}
      current_user.save
      redirect "/reviews/#{@review.id}"
    end
  end

  get '/reviews/:id' do
    @review = Review.find(params["id"])
    erb :'/reviews/show'
  end

  delete '/reviews/:id/delete'do
    if logged_in?
      @review = Review.find(params["id"])
      if @review && @review.user == current_user
        @review.delete
        redirect "/users/#{current_user.id}"
      end
    else
      redirect '/login'
    end
  end

  get '/reviews/:id/edit' do
    @review = Review.find(params["id"])
    if logged_in?
      if @review && current_user.id == @review.user.id
        erb :'/reviews/edit'
      else
        redirect "/users/#{current_user.id}"
      end
    else
      redirect '/login'
    end
  end

  patch '/reviews/:id/edit' do
    @review = Review.find(params["id"])
    if params["review"]["look"].empty? || params["review"]["smell"].empty? || params["review"]["taste"].empty? || params["review"]["feel"].empty?
      session[:message] = "Must enter a number for each of the first 4 fields!"
      redirect "/reviews/#{@review.id}/edit"
    else
      @review.look = params["review"]["look"]
      @review.smell = params["review"]["smell"]
      @review.taste = params["review"]["taste"]
      @review.feel = params["review"]["feel"]
      @review.content = params["review"]["content"]
      @review.save
      redirect "/reviews/#{@review.id}"
    end
  end

end
