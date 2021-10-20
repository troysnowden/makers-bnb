require_relative 'database_connection'

class UserAccess

    class << self

      def user_registartion(first_name, last_name)
        result = DatabaseConnection.connect_to_db.exec_params(
        "INSERT INTO users (first_name, last_name) VALUES($1, $2) RETURNING id, first_name, last_name;", [first_name, last_name])
        
        User.new(result[0]['id'], result[0]['first_name'], result[0]['last_name'])
      end  
      
    end

end 