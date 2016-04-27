class ConsoleUI

    def initialize()
        @running = true
    end

    def in(uString)
        case uString
        when "help"
            self.printHelp
        when "exit"
            puts "Adios!"
            @running = false
        else
            puts "'#{uString}' is not a recognised command..."
            self.printHelp
        end
    end

    def start()
        while @running
            print "\n> "
            uInput = gets.chomp
            self.in(uInput)
        end
    end

    def printHelp()
        puts ""
        puts "Console App 1.0"
        puts "---------------"
        puts "help : prints out this menu"
        puts "exit : will close the programme"
    end
end
