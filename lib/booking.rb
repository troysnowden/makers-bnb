# frozen_string_literal: true

class Booking
  attr_reader :accommodation_id, :visitor_id, :total_cost, :booked_date, :confirmed

  def initialize(visitor_id, accommodation_id, booked_date, total_cost)
    @accommodation_id = accommodation_id
    @visitor_id = visitor_id
    @total_cost = total_cost
    @booked_date = booked_date
    @confirmed = false
  end

  # def self.all
  #   if ENV['ENVIRONMENT'] == 'test'
  #     connection = PG.connect(dbname: 'bookmark_manager_test')
  #   else
  #     connection = PG.connect(dbname: 'bookmark_manager')
  #   end
  #   result = connection.exec("SELECT * FROM bookmarks")
  #   result.map do |bookmark|
  #     Bookmarks.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
  #   end
  # end

  def self.create(visitor_id:, accommodation_id:, booked_date:, total_cost:)
    if ENV['ENVIRONMENT'] == 'test'
     connection = PG.connect(dbname: 'mbnb_test')
    else
     connection = PG.connect(dbname: 'mbnb')
    end

    result = connection.exec_params(
      "INSERT INTO bookings (visitor_id, accommodation_id, booked_date, total_cost) VALUES($1, $2, $3, $4) RETURNING id, visitor_id, accommodation_id, booked_date, total_cost;", [visitor_id, accommodation_id, booked_date, total_cost]
    )
    Booking.new(id: result[0]['id'], visitor_id: result[0]['visitor_id'], accommodation_id: result[0]['accommodation_id'], booked_date: result[0]['booked_date'], total_cost: result[0]['total_cost'])
  end  

  def confirm
    @confirmed = true
  end
end
