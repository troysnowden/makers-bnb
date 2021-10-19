# frozen_string_literal: true

require 'pg'

task :test_database_setup do
  p 'Cleaning database...'

  connection = PG.connect(dbname: 'mbnb_test')

  # Clear the database
  connection.exec('TRUNCATE users CASCADE;')
  connection.exec('TRUNCATE accommodations;')
  #  connection.exec("TRUNCATE bookings;")

  # Add the test data
end

task :setup do
  p 'Creating databases...'

  %w[mbnb mbnb_test].each do |database|
    connection = PG.connect
    connection.exec("CREATE DATABASE #{database};")
    connection = PG.connect(dbname: database)
    connection.exec('CREATE TABLE users(id SERIAL PRIMARY KEY, first_name VARCHAR(60), last_name VARCHAR(60));')
    connection.exec('CREATE TABLE accommodations(id SERIAL PRIMARY KEY, owner_id INT REFERENCES users(id), name VARCHAR(60), description VARCHAR(120), price_per_night NUMERIC(5,2));')
    # TODO: same as above for bookings table
  end
end
