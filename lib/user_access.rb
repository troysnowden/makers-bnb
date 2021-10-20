class UserAccess

    def user_registartion(first_name , last_name)
      if ENV['ENVIRONMENT'] == 'test'
        connection = PG.connect(dbname: 'mbnb_test')
      else
        connection = PG.connect(dbname: 'mbnb')
      end

      result = connection.exec_params(
    
      "INSERT INTO users (first_name, last_name) VALUES($1, $2) RETURNING id, first_name, last_name;", [first_name, last_name])
      User.new(result[0]['id'], result[0]['first_name'], result[0]['last_name'])


    end  

end 