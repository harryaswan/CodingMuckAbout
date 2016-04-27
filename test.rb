# require_relative("console.rb")
#
# consoleUI = ConsoleUI.new
# consoleUI.start

@items = {
    pizza: 4.99,
    steak_pie: 6.99,
    pasta: 7.99,
    cola: 1.99,
    pizza: 4.99,
    lemonade: 1.99,
    water: 0.00
}

puts @items

@items.delete(:pizza)

puts @items
