require_relative("../db/sql_runner")
require_relative("./films")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = 'INSERT INTO customer
    (
      name,
      funds
    )
    VALUES (
      $1, $2
    )
    RETURNING id;'
    values = [@name, @funds]
    result = SqlRunner.run( sql, values )
    @id = result[0]['id'].to_i()
  end

  def update()
    sql = 'UPDATE customer SET
    (
      name,
      funds
    ) = (
      $1, $2
    )
    WHERE id = $3;'
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = 'SELECT * FROM customer'
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map {|customer_hash| Customer.new(customer_hash)}
    return result
  end

  def self.delete_all()
    sql = 'DELETE FROM customer'
    values = []
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM customer WHERE id = $1;'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def films_seen()
    sql = 'SELECT films.title FROM films
    INNER JOIN tickets ON films.id = tickets.films_id
    WHERE customer_id = $1;'
    values = [@id]
    result = SqlRunner.run(sql, values)
    array = Array.new
    films = result.map {|hash| Film.new(hash)}
    for item in films do
        array.push(item.title)
    end
      return array
  end

  def tickets_bought()
    sql = 'SELECT * FROM tickets
    WHERE tickets.customer_id = $1'
    values = [@id]
    result = SqlRunner.run(sql, values)
    count = result.map {|hash| Ticket.new(hash)}.length
    return count
  end

  def update_funds()
    spend = self.tickets_bought * 5
    self.funds -= spend
    self.update
    return self.funds
  end

end
