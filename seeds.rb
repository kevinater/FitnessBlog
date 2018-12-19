# Run this script with `bundle exec ruby seeds.rb`
require 'sqlite3'
require 'active_record'

#require model classes
# require './models/cake.rb'
require '.models/user.rb'
require '.models/post.rb'

# Use `binding.pry` anywhere in this script for easy debugging
require 'pry'
require 'csv'

# Connect to a sqlite3 database
# If you feel like you need to reset it, simply delete the file sqlite makes
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.db'
)

# Storing all user characteristics
# user_data = User.all.each do [row]
#   first_name = row[1]
#   last_name = row[2]
#   birthday = row[3]
#   email = row[4]
#   avatar = row[5]
#
#   User.create(first_name: first_name, last_name: last_name, birthday: birthday, email: email, avatar: avatar)
#
# end


binding.pry
