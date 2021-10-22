require_relative 'accommodation'
require_relative 'database_connection'

class AccommodationAccess
  class << self

    @@database_connection = DatabaseConnection.connect_to_db

    def all_owned_by_user(user_id)
      result = @@database_connection.exec_params('SELECT * FROM accommodations WHERE owner_id = $1;', [user_id])

      map_records_to_array_of_accommodation_objects(result)
    end

    def all_available_within_max_price_on_date(max_price, chosen_date)
      result = @@database_connection.exec_params(
        "SELECT * from accommodations WHERE price_per_night <= $1 AND id NOT IN (SELECT accommodation_id FROM bookings where date = $2 AND confirmed);",
         [max_price, chosen_date])

         map_records_to_array_of_accommodation_objects(result)
    end

    def create(user_id, name, description, price_per_night)
      # insert accommodation into accommodations table
      result = @@database_connection.exec_params(
        "INSERT INTO accommodations(owner_id, name, description, price_per_night) VALUES ($1, $2, $3, $4) RETURNING *;", 
[user_id, name, description, price_per_night])
      map_records_to_single_booking_object(result)
    end

    def filter_by_accom_id(accommodation_id) # pass in accommodation_id?
      # get all accommodations where accommodation_id = id
      result = @@database_connection.exec_params('SELECT * FROM accommodations WHERE id = $1;', [accommodation_id])
      
      map_records_to_single_booking_object(result)
    end

    private

    def map_records_to_single_booking_object(records)
      Accommodation.new(
        records[0]['id'], records[0]['owner_id'], records[0]['name'], records[0]['description'], records[0]['price_per_night']
      )
    end

    def map_records_to_array_of_accommodation_objects(records)
      records.map{ |accommodation| 
        Accommodation.new(accommodation['id'], accommodation['user_id'], 
          accommodation['name'], accommodation['description'], accommodation['price_per_night']) }
    end
  end
end