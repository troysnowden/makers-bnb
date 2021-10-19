# frozen_string_literal: true

class Booking
  attr_reader :accom_id, :visitor_id, :total_cost, :arrival_date, :departure_date, :confirmed

  def initialize(accom_id, visitor_id, total_cost, arrival_date, departure_date)
    @accom_id = accom_id
    @visitor_id = visitor_id
    @total_cost = total_cost
    @arrival_date = arrival_date
    @departure_date = departure_date
    @confirmed = false
  end

  def confirm
    @confirmed = true
  end
end
