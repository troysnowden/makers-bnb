require_relative 'database_connection'
require_relative 'user'

class UserAccess

    class << self

      def register(first_name, last_name)
        result = DatabaseConnection.connect_to_db.exec_params(
        "INSERT INTO users (first_name, last_name) VALUES($1, $2) RETURNING id, first_name, last_name;", [first_name, last_name])
        
        User.new(result[0]['id'], result[0]['first_name'], result[0]['last_name'])
      end 
      
      def login(first_name, last_name)
        ## check given names are in db, if so return user, otherwise return false
        result = DatabaseConnection.connect_to_db.exec_params(
          "SELECT * FROM users WHERE first_name = $1 AND last_name = $2;",  [first_name, last_name])
        return false unless result.ntuples.positive?
        User.new(result[0]['id'], result[0]['first_name'], result[0]['last_name'])
        
      end

    end

end 