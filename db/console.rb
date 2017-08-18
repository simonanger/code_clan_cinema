require_relative( '../models/customers' )
require_relative( '../models/films' )

require( 'pry-byebug' )

customer1 = Customer.new({ 'name' => 'Simon', 'funds' => '20' })
customer2 = Customer.new({ 'name' => 'Maisie', 'funds' => '20' })
customer3 = Customer.new({ 'name' => 'Katie', 'funds' => '20' })

film1 = Film.new ({ 'title' => 'Star Wars', 'price' => '5' })

binding.pry
nil
