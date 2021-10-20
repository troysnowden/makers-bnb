require 'pg'

def persisted_data(id:)
  connection = PG.connect(dbname: 'mbnb_test')
  result = connection.query("SELECT * FROM bookings WHERE id = #{id};")
  result.first
end