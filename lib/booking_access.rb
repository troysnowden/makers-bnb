class BookingAccess
  class << self
    def all_requests_for_accommodation_owner(user_id)
      # something like:
      # SELECT * from bookings WHERE confirmed = false AND accomodation_id IN (SELECT id from accommodations WHERE owner_id = #{user_id})
    end

    def all_confirmed_for_accommodation_owner(user_id)
      # something like:
      # SELECT * from bookings WHERE confirmed = true AND accomodation_id IN (SELECT id from accommodations WHERE owner_id = #{user_id})
    end

    def all_requests_for_visitor(f,user_id)
      # something like:
      # SELECT * from bookings WHERE confirmed = false AND visitor_id = #{user_id})
      result = DatabaseConnection.connect_to_db.exec_params(
        "SELECT * FROM bookings where (confirmed = $1 AND visitor_id = $2);", [f,user_id])
       
      result.map{ |visitor_request| Booking.new(visitor_request['id'], visitor_request['visitor_id'], visitor_request['accommodation_id'], visitor_request['total_cost'], visitor_request['date'])}
    end

    def all_confirmed_for_visitor(user_id)
      # something like:
      # SELECT * from bookings WHERE confirmed = true AND visitor_id = #{user_id})
    end

    def create(visitor_id, accommodation_id, total_cost, date)
      result = DatabaseConnection.connect_to_db.exec_params(
        "INSERT INTO bookings(visitor_id, accommodation_id, confirmed, total_cost, date) VALUES ($1, $2, $3, $4, $5) RETURNING *;", 
[visitor_id, accommodation_id, false, total_cost, date])
      Booking.new(
        result[0]['id'], result[0]['visitor_id'], result[0]['accommodation_id'], result[0]['total_cost'], result[0]['date']
      )
    end

    def confirm_booking_when_request_accepted(booking_id)
      
    end

    def delete_booking_when_request_denied(booking_id)
    end
  end
end