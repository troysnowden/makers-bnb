require_relative 'database_connection'
require_relative 'user'

class UserAccess

    class << self

      @@database_connection = DatabaseConnection.connect_to_db

      def register(first_name, last_name)
        result = @@database_connection.exec_params(
        "INSERT INTO users (first_name, last_name) VALUES($1, $2) RETURNING id, first_name, last_name;", [first_name, last_name])
        
        map_single_record_to_user_object(result)
      end 
      
      def login(first_name, last_name)
        ## check given names are in db, if so return user, otherwise return nil
        result = @@database_connection.exec_params(
          "SELECT * FROM users WHERE first_name = $1 AND last_name = $2;",  [first_name, last_name])
        return nil unless result.ntuples.positive?
        
        map_single_record_to_user_object(result)
      end

      private

      def map_single_record_to_user_object(record)
        User.new(record[0]['id'], record[0]['first_name'], record[0]['last_name'])
      end

    end

end 