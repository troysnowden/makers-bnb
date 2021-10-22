require 'booking'

class BookingAccess
  class << self

    @@database_connection = DatabaseConnection.connect_to_db

    def all_requests_for_accommodation_owner(user_id)
      result = @@database_connection.exec_params(
        "SELECT * FROM bookings WHERE NOT confirmed AND accommodation_id IN
        (SELECT id from accommodations WHERE owner_id = $1);",[user_id])
      
      map_records_to_array_of_booking_objects(result)
    end

    def all_confirmed_for_accommodation_owner(user_id)
      result = @@database_connection.exec_params(
        "SELECT * from bookings WHERE confirmed AND accommodation_id IN 
        (SELECT id from accommodations WHERE owner_id = $1);", [user_id])
        
      map_records_to_array_of_booking_objects(result)
    end

    def all_requests_for_visitor(user_id)
      result = @@database_connection.exec_params(
        "SELECT * FROM bookings WHERE NOT confirmed AND visitor_id = $1;", [user_id])
      
      map_records_to_array_of_booking_objects(result)
    end

    def all_confirmed_for_visitor(user_id)
      result = @@database_connection.exec_params(
        "SELECT * from bookings WHERE confirmed AND visitor_id = $1;", [user_id])

      map_records_to_array_of_booking_objects(result)
    end

    def create(visitor_id, accommodation_id, total_cost, date)
      result = @@database_connection.exec_params(
        "INSERT INTO bookings(visitor_id, accommodation_id, confirmed, total_cost, date) VALUES ($1, $2, $3, $4, $5) RETURNING *;", 
[visitor_id, accommodation_id, false, total_cost, date])
        map_single_record_to_booking_object(result)
    end

    def confirm_booking_when_request_accepted(booking_id)
      result = @@database_connection.exec_params(
        "UPDATE bookings SET confirmed = $1 WHERE id = $2 RETURNING *;", [true, booking_id])
      
      map_single_record_to_booking_object(result)
    end

    def delete_booking_when_request_denied(booking_id)
      result = @@database_connection.exec_params(
        "DELETE FROM bookings WHERE id = $1;", [booking_id])
    end

    private

    def map_single_record_to_booking_object(record)
      Booking.new(
        record[0]['id'], record[0]['visitor_id'], record[0]['accommodation_id'], 
        record[0]['total_cost'], record[0]['date'], record[0]['confirmed']
      )
    end

    def map_records_to_array_of_booking_objects(records)
      records.map{ |record| 
        Booking.new(record['id'], record['visitor_id'], 
          record['accommodation_id'], record['total_cost'], record['date'], record['confirmed']) }
    end
  end
end