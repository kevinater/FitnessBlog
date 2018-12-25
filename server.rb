require 'sinatra'
require "sinatra/reloader"

# Run this script with `bundle exec ruby app.rb`
require 'sqlite3'
require 'active_record'

#require model classes
# require './models/cake.rb'
require './models/user.rb'
require './models/post.rb'

# Use `binding.pry` anywhere in this script for easy debugging
require 'pry'


# Connect to a sqlite3 database
# If you feel like you need to reset it, simply delete the file sqlite makes
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.db'
)

register Sinatra::Reloader
enable :sessions

get '/' do
  erb :index
end

get '/signup' do
  erb :signup
end

get '/login' do
  erb :login
end

post '/newuser/signup' do
  already_user = User.find_by(email: params["email"])
  if already_user
    redirect '/login'
  else
    new_user = User.create(first_name: params["first_name"], last_name: params["last_name"], email: params["email"], birthday: params["birthday"], password: params["password"])
    session[:user_id] = new_user.id
    redirect '/'
  end
end

get '/user/feed' do
  erb :blogfeed
end

