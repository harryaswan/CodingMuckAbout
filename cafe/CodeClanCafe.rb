require_relative("ConsoleUI")
require_relative("CafeConsole")
require_relative("Cafe")
require_relative("Table")
require_relative("Order")
require_relative("Item")
require_relative("Menu")


target = ARGV.join ' '
puts "Args: #{target}"

puts "\nWelcome to Cafe CodeClan..."

con = CafeConsole.new()
con.start
