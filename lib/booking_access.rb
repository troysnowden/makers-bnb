require 'booking'

class BookingAccess
  class << self
    def all_requests_for_accommodation_owner(user_id)
      result = DatabaseConnection.connect_to_db.exec_params(
        "SELECT * FROM bookings WHERE NOT confirmed AND accommodation_id IN
        (SELECT id from accommodations WHERE owner_id = $1);",[user_id])
      
      result.map{ |booking_request| 
      Booking.new(booking_request['id'], booking_request['visitor_id'], 
      booking_request['accommodation_id'], booking_request['total_cost'],booking_request['date'], booking_request['confirmed']) }
        
    end

    def all_confirmed_for_accommodation_owner(user_id)
      result = DatabaseConnection.connect_to_db.exec_params(
        "SELECT * from bookings WHERE confirmed AND accommodation_id IN 
        (SELECT id from accommodations WHERE owner_id = $1);", [user_id])
      result.map{ 
        |owner_request| 
        Booking.new(
          owner_request['id'], owner_request['visitor_id'], owner_request['accommodation_id'], 
          owner_request['total_cost'], owner_request['date'], owner_request['confirmed'])}
    end

    def all_requests_for_visitor(user_id)
      result = DatabaseConnection.connect_to_db.exec_params(
        "SELECT * FROM bookings WHERE NOT confirmed AND visitor_id = $1;", [user_id])
      result.map{ 
        |visitor_request| 
        Booking.new(
          visitor_request['id'], visitor_request['visitor_id'], visitor_request['accommodation_id'], 
          visitor_request['total_cost'], visitor_request['date'], visitor_request['confirmed'])}
    end

    def all_confirmed_for_visitor(user_id)
      bookings = []
      result = DatabaseConnection.connect_to_db.exec_params(
        "SELECT * from bookings WHERE confirmed AND visitor_id = $1;", [user_id])

      result.each do |r|
        bookings << Booking.new(
          r['id'], r['visitor_id'], r['accommodation_id'], r['total_cost'], r['date'], r['confirmed']
        )
      end
      bookings
    end

    def create(visitor_id, accommodation_id, total_cost, date)
      result = DatabaseConnection.connect_to_db.exec_params(
        "INSERT INTO bookings(visitor_id, accommodation_id, confirmed, total_cost, date) VALUES ($1, $2, $3, $4, $5) RETURNING *;", 
[visitor_id, accommodation_id, false, total_cost, date])
      Booking.new(
        result[0]['id'], result[0]['visitor_id'], result[0]['accommodation_id'], result[0]['total_cost'], result[0]['date'], result[0]['confirmed']
      )
    end

    def confirm_booking_when_request_accepted(booking_id)
      result = DatabaseConnection.connect_to_db.exec_params(
        "UPDATE bookings SET confirmed = $1 WHERE id = $2 RETURNING *;", [true, booking_id])
      Booking.new(
        result[0]['id'], result[0]['visitor_id'], result[0]['accommodation_id'], result[0]['total_cost'], result[0]['date'], result[0]['confirmed']
      )
    end

    def delete_booking_when_request_denied(booking_id)
    end
  end
end