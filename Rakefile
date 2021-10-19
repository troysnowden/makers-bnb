require 'pg'

 task :test_database_setup do
   p "Cleaning database..."

   connection = PG.connect(dbname: 'MBNB_test')

   # Clear the database
   connection.exec("TRUNCATE users;")
  #  connection.exec("TRUNCATE accommodations;")
  #  connection.exec("TRUNCATE bookings;")

   # Add the test data
   
   
 end

 task :setup do
   p "Creating databases..."

   ['MBNB', 'MBNB_test'].each do |database|
     connection = PG.connect
     connection.exec("CREATE DATABASE #{ database };")
     connection = PG.connect(dbname: database)
     connection.exec("CREATE TABLE users(id SERIAL PRIMARY KEY, first_name VARCHAR(60), last_name VARCHAR(60));")
     # TODO: same as above for accommodations table
     # TODO: same as above for bookings table
   end
 end