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

    def all_requests_for_visitor(user_id)
      # something like:
      # SELECT * from bookings WHERE confirmed = false AND visitor_id = #{user_id})
    end

    def all_confirmed_for_visitor(user_id)
      # something like:
      # SELECT * from bookings WHERE confirmed = true AND visitor_id = #{user_id})
    end

    def create(booking)
      
    end

    def confirm_booking_when_request_accepted(booking_id)
    end

    def delete_booking_when_request_denied(booking_id)
    end
  end
end