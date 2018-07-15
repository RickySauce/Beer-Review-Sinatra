class BeersController < ApplicationController

  get '/beers' do
    erb :'/beers/beers'
  end
end
