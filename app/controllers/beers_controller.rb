class BeersController < ApplicationController

  get '/beers' do
    erb :'/beers/beers'
  end

  get '/beers/user' do
    if logged_in?
      erb :'/beers/user'
    else
      redirect '/login'
    end
  end

  get '/beers/:id' do
    @beer = Beer.find(params["id"])
    erb :'/beers/show'
  end

  post '/beers/:id/add' do
    @beer = Beer.find(params["id"])
    if @beer
      if current_user.beers.any? {|beer| beer.id == @beer.id}
        redirect "/beers/#{@beer.id}"
      else
        current_user.beers << @beer
        current_user.save
        redirect "/users/#{current_user.id}"
      end
    else
      redirect '/beers'
    end
  end

  delete '/beers/:id/remove' do
    @beer = Beer.find(params["id"])
    @review = current_user.reviews.find {|review| review.beer_id == @beer.id}
    current_user.beers.delete(@beer)
    current_user.reviews.delete(@review) if @review
    current_user.save
    redirect "/users/#{current_user.id}"
  end

end
