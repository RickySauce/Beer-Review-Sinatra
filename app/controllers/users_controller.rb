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
    session.clear
    redirect '/'
  end

  get '/add' do
    erb :'/users/add'
  end

  get '/review' do

  end

end
