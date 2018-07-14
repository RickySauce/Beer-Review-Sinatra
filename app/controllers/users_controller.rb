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

  get '/users' do
    erb :'/users/users'
  end

end
