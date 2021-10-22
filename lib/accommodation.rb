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
end