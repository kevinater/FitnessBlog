# Run this script with `bundle exec ruby seeds.rb`
require 'active_record'

#require model classes
# require './models/cake.rb'
require './models/user.rb'
require './models/post.rb'

# Use `binding.pry` anywhere in this script for easy debugging
require 'pry'
require 'csv'

if ENV['DATABASE_URL']
  require 'pg'
  # use DATABASE_URL since this is Heroku
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
  require 'sqlite3'
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'db/development.db'
  )
end

#Storing all user data

first_user = User.create(first_name: "Kevin", last_name: "Vee", birthday: "January 5th 1996", email: "keviniscool@gmaaaaail.com")

for x in (0..30)
    Post.create(title: "Post number:" + x.to_s, text: "text", user_id: 1)
end
