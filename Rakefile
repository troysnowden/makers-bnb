# frozen_string_literal: true

require 'pg'

# :nocov:
task :test_database_setup do
   p "Cleaning database..."

  connection = PG.connect(dbname: 'mbnb_test')

  # Clear the database
  connection.exec('TRUNCATE users CASCADE;')

  # Add the test data
  
end

task :setup do
  p 'Creating databases...'

  %w[mbnb mbnb_test].each do |database|
    connection = PG.connect
    connection.exec("DROP DATABASE #{database};")
    connection.exec("CREATE DATABASE #{database};")
    connection = PG.connect(dbname: database)
    connection.exec('CREATE TABLE users(id SERIAL PRIMARY KEY, first_name VARCHAR(60), last_name VARCHAR(60));')
    connection.exec('CREATE TABLE accommodations(id SERIAL PRIMARY KEY, owner_id INT REFERENCES users(id), name VARCHAR(60), description VARCHAR(120), price_per_night NUMERIC(5,2));')
    connection.exec('CREATE TABLE bookings(id SERIAL PRIMARY KEY, visitor_id INT REFERENCES users(id), accommodation_id INT REFERENCES accommodations(id), confirmed bool, total_cost NUMERIC(5,2), date DATE);')
  end
end

task :populate_accoms do
  %w[mbnb mbnb_test].each do |database|
    connection = PG.connect(dbname: database)
    user_id = connection.exec('INSERT INTO users(first_name,last_name) VALUES(\'John\',\'Smith\') RETURNING id;')[0]["id"]  
    connection.exec("INSERT INTO accommodations(owner_id,name, description, price_per_night, date) VALUES(#{user_id},\'Sunny Sands\',\'course and rough\',\'80.00\', 2021-10-25);")
    connection.exec("INSERT INTO accommodations(owner_id,name, description, price_per_night, date) VALUES(#{user_id},\'Coastal Chalet\',\'nice pillows\',\'40.00\', 2021-10-25);")  
    connection.exec("INSERT INTO accommodations(owner_id,name, description, price_per_night, date) VALUES(#{user_id},\'Riviera Retreat\',\'great apart from the smell\',\'99.00\', 2021-10-25);")
  end
  
end
# :nocov:

