require 'accommodation'

class AccommodationAccess
  class << self
    def all_owned_by_user(user) # pass in user or user_id?
      # get all accommodations where owner_id = user.user_id
    end

    def all_available_within_max_price_on_date(max_price, chosen_date)
      accommodation_array = []
      # get all accommodations from database within max price
      # loop through each accommodation found and check whether there is a booking for chosen date, and filter out if so
      # return an array of accommodation objects
      result = DatabaseConnection.connect_to_db.exec_params(
        "SELECT * from accommodations WHERE price_per_night <= $1 AND $2 NOT IN (SELECT date FROM bookings);", [max_price, chosen_date])

      result.each do |r|
        accommodation_array << Accommodation.new(r['id'], r['owner_id'], r['name'], r['description'], r['price_per_night'])
      end
      accommodation_array
    end

    def create(user, name, description, price_per_night)
      # insert accommodation into accommodations table
      result = DatabaseConnection.connect_to_db.exec_params(
        "INSERT INTO accommodations(owner_id, name, description, price_per_night) VALUES ($1, $2, $3, $4) RETURNING id, owner_id, name, description, price_per_night;", 
[user.user_id, name, description, price_per_night])
      Accommodation.new(
        result[0]['id'], result[0]['owner_id'], result[0]['name'], result[0]['description'], result[0]['price_per_night']
      )
    end
  end
end