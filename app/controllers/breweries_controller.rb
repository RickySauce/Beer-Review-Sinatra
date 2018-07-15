class BreweriesController < ApplicationController

  get '/breweries' do
      erb :'/breweries/breweries'
  end

  get '/breweries/:id' do
    @brewery = Brewery.find_by_id(params["id"])
    if @brewery
      erb :'/breweries/show'
    else
      redirect '/breweries'
    end
  end

end
