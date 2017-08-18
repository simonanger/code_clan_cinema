require_relative("../db/sql_runner")
require_relative("./films")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customer
    (
        name,
        funds
    )
    VALUES (
      $1, $2
    )
    RETURNING id"
    values = [@name, @funds]
    result = SqlRunner.run( sql, values )
    @id = result[0]['id'].to_i()

  end

end
