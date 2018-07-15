class BeersController < ApplicationController

  get '/beers' do
    erb :'/beers/beers'
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

end
