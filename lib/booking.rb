# frozen_string_literal: true

class Booking
  attr_reader :accom_id, :visitor_id, :total_cost, :date, :confirmed

  def initialize(accom_id, visitor_id, total_cost, date)
    @accom_id = accom_id
    @visitor_id = visitor_id
    @total_cost = total_cost
    @date = date
    @confirmed = false
  end

  def confirm
    @confirmed = true
  end
end
