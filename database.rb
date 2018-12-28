# Run this script with `bundle exec database.rb`
require 'sqlite3'
require 'active_record'

#require model classes
# require './models/cake.rb'
require './models/user.rb'
require './models/post.rb'

# Use `binding.pry` anywhere in this script for easy debugging
require 'pry'
require 'csv'

# Connect to a sqlite3 database
# If you feel like you need to reset it, simply delete the file sqlite makes
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.db'
)

#use this file to open pry
#Storing data for gitpod
# first_user = User.create(first_name: "Kevin", last_name: "Vee", birthday: "January 5th 1996", email: "kevin@gmaaaaail.com")

binding.pry
