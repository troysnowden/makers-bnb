# frozen_string_literal: true

class Booking
  attr_reader :booking_id, :accommodation_id, :visitor_id, :total_cost, :date, :confirmed

  def initialize(booking_id, visitor_id, accom_id, total_cost, date)
    @booking_id = booking_id
    @visitor_id = visitor_id
    @accommodation_id = accom_id
    @total_cost = total_cost
    @date = date
    @confirmed = false
  end

  def confirm
    @confirmed = true
  end
end
