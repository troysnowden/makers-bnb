require_relative 'database_connection'

class Accommodation
    attr_reader :accommodation_id, :owner_id, :name, :description, :price_per_night

    def initialize(id, user_id, name, description, price)
        @accommodation_id = id
        @owner_id = user_id
        @name = name
        @description = description
        @price_per_night = price
    end

    class << self
        def create(owner_id, name, description, price_per_night)
            result = DatabaseConnection.connect_to_db.exec_params(
            "INSERT INTO accommodations (owner_id, name, description, price_per_night) VALUES($1, $2, $3, $4) RETURNING id, owner_id, name, description, price_per_night;", [owner_id, name, description, price_per_night])
            
            Accommodation.new(result[0]['id'], result[0]['owner_id'], result[0]['name'], result[0]['description'], result[0]['price_per_night'])
        end 
    end
    
end