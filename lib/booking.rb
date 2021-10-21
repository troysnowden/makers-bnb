class Booking

  attr_reader :accommodation_id, :visitor_id, :total_cost, :date, :confirmed

  def initialize(visitor_id, accommodation_id, date, total_cost)
    @visitor_id = visitor_id
    @accommodation_id = accommodation_id
    @total_cost = total_cost
    @date = date
    @confirmed = false
  end

  def confirm
    @confirmed = true
  end
end
