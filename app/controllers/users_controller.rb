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
    @user = User.find(params["id"])
    erb :'/users/show'
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/'
    else
      redirect '/'
    end
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
      @beer = Beer.find_by(name: params["name"])
      if @beer
        current_user.beers << @beer
        current_user.save
      else
        session[:message] = "Sorry, that beer does not exist, please enter a new name"
        redirect '/add'
      end
    end
  end

  get '/review' do
    if logged_in?
      erb :'/reviews/add'
    else
      redirect '/login'
    end
  end

end
