require 'pg'

class DatabaseConnection
  class << self
    def connect_to_db
      database_name = ENV['RACK_ENV'] == 'development' ? 'mbnb' : 'mbnb_test'
      PG.connect dbname: database_name, user: ENV['USER']
    end
  end
end
