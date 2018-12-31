require 'sinatra'
require "sinatra/reloader"
require 'bcrypt'

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
  @all_posts = Post.all.order(id: :desc)
  erb :index
end

post '/post' do
#Creating a new post
    if current_user
        new_post = Post.create(title: params["title"], text: params["text"], user_id: current_user.id)
        redirect '/'
    else
        redirect '/login'
    end
end

get '/signup' do

  erb :signup
end

get '/login' do
  erb :login
end

post '/login' do
  user = get_user_by_email
  if !user || !check_password(params["password"], user.password)
    redirect '/signup'
  else
    session[:user_id] = user
    redirect '/'
  end
end

post '/logout' do
  session[:user_id] = nil
  redirect '/login'
end

post '/newuser/signup' do
  if get_user_by_email
    redirect '/login'
  else
    new_user = User.create(first_name: params["first_name"], last_name: params["last_name"], email: params["email"], birthday: params["birthday"], password: generate_password_hash(params["password"]))
    session[:user_id] = new_user

    redirect '/'
  end
end

get '/user/feed/:id' do

  @user = User.find(params["id"])
  if !@user || !current_user
    redirect '/login'
  else
    @posts = @user.posts.order(id: :asc).to_a.last(20).reverse
    

   erb :blogfeed
  end
end


helpers do
  def generate_password_hash(password)
    BCrypt::Password.create(password).to_s
  end
  def check_password(password, encrypted_password)
    BCrypt::Password.new(encrypted_password) == password
  end
  def get_user_by_email
    User.find_by(email: params["email"])
  end
  def current_user
    session[:user_id]
  end
end