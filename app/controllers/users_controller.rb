class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'/users/signup'
    else
      redirect "/users/#{current_user.id}"
    end
  end

  post '/signup' do
    if User.all.any? {|user| user.username == params["username"]}
      session[:message] = "Sorry, Username already taken!"
      redirect "/signup"
    else
      if params.any? {|key,value| value.empty?}
        session[:message] = "Sorry, Make sure all fields are filled out!"
        redirect '/signup'
      else
        @user = User.create(params)
        session[:user_id] = @user.id
        redirect "/users/#{@user.id}"
      end
    end
    # - merge redirect signups
  end

  get '/login' do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if @user && @user.authenticate(params["password"])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      session[:message] = "Sorry, incorrect Username or Password"
      redirect '/login'
    end
  end

  get '/users' do
    erb :'/users/users'
  end

  get '/users/:id' do
    session[:message].clear if !session[:message].blank?
    @user = User.find_by_id(params["id"])
    if @user
      erb :'/users/show'
    else
      redirect '/users'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/'
    else
      redirect '/'
    end
    # -merge redirect '/'
  end

  get '/add' do
    if logged_in?
      erb :'/beers/add'
    else
      redirect '/login'
    end
  end

  post '/add' do
    if params["name"].empty?
      session[:message] = "Please enter a name"
      redirect '/add'
    else
      @beer = Beer.all.find {|beer| beer.name.downcase == params["name"].downcase}
      if @beer
        if current_user.beers.any? {|beer| beer == @beer}
          session[:message] = "Sorry, that beer is already in your portfolio"
          redirect '/add'
        else
          current_user.beers << @beer
          current_user.save
          redirect "/users/#{current_user.id}"
        end
      else
        session[:message] = "Sorry, that beer does not exist, please enter a new name"
        redirect '/add'
      end
    end
    # - merge redirect '/add'
  end

  get '/review' do
    if logged_in?
      erb :'/reviews/add'
    else
      redirect '/login'
    end
  end

  post '/review' do
    if params["name"].empty?
      session[:message] = "Please enter a name"
      redirect '/add'
    else
      @beer = Beer.all.find {|beer| beer.name.downcase == params["name"].downcase}
      if @beer
        if current_user.reviews.any? {|review| review.beer_id == @beer.id}
          session[:message] = "You have already reviewed this beer!"
          redirect "/reviews/:id"
        else
          session[:beer] = @beer
          redirect '/reviews/new'
        end
      else
        session[:message] = "Sorry, that beer does not exist, please enter a new name"
        redirect '/add'
      end
    end
  end

end
