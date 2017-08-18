require_relative( '../models/customers' )
require_relative( '../models/films' )
require_relative( '../models/tickets')

require( 'pry-byebug' )

customer1 = Customer.new({ 'name' => 'Simon', 'funds' => '20' })
customer2 = Customer.new({ 'name' => 'Maisie', 'funds' => '20' })
customer3 = Customer.new({ 'name' => 'Katie', 'funds' => '20' })
customer1.save
customer2.save
customer3.save

film1 = Film.new ({ 'title' => 'Star Wars', 'price' => '5' })
film2 = Film.new ({ 'title' => 'Alien', 'price' => '5' })
film1.save
film2.save

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'films_id' => film1.id })
ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'films_id' => film2.id })
ticket1.save
ticket2.save

binding.pry
nil
