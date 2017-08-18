require('../db/sql_runner')
require_relative( '../models/customers' )
require_relative( '../models/films' )

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :films_id

  def initialize( params )
    @id = params['id'].to_i()
    @customer_id = params['customer_id'].to_i()
    @films_id = params['films_id'].to_i()
  end

  def save()
    sql = 'INSERT INTO tickets
    (
    customer_id,
    films_id
    )
    VALUES (
    $1, $2
    )
    RETURNING id'
    values = [@customer_id, @films_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i()
  end

  def self.all()
    sql = 'SELECT * FROM tickets'
    values = []
    tickets = SqlRunner.run(sql, values)
    result = tickets.map {|hash| Ticket.new(hash)}
    return result
  end

  def self.delete_all()
    sql = 'DELETE FROM tickets'
    values = []
    SqlRunner.run(sql, values)
  end


end
