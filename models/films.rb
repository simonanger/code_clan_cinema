require_relative("../db/sql_runner")
require_relative("./customers")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = 'INSERT INTO films (
    title,
    price
    )
    VALUES (
    $1, $2
    )
    RETURNING *;'
    values = [@title, @price]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i()
  end

  def update()
    sql = 'UPDATE films SET(
    title,
    price
    ) = (
    $1, $2
    )
    WHERE id = $3;'
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = 'SELECT * FROM films'
    values = []
    films = SqlRunner.run(sql, values)
    result = films.map {|hash| Film.new(hash)}
    return result
  end

end
