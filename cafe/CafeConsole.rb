class CafeConsole < ConsoleUI

    def initialize
        super()
        @cafe = Cafe.new
        @errors = nil
    end

    def in(uString)

        @errors = nil
        uString = uString.split(" ")

        # lookup = {
        #
        #     "sett" => @cafe.set_tables(uString[1].to_i),
        #     "seat" => @cafe.set_tables(uString[1].to_i)
        #
        # }
        #
        # @errors = lookup[uString[0]]

        case uString[0]
        when "settables", "sett"
            @errors = @cafe.set_tables(uString[1].to_i)
        when "addtable", "add"
            @errors = @cafe.add_table()
        when "seattable", "seat"
            @errors = @cafe.seat_table(uString[1], uString[2])
        when "selecttable", "selt"
            @errors = @cafe.select_table(uString[1].to_i)
        when "viewselectedtable", "vst"
            @errors = @cafe.view_selected_table()
        when "unselecttable", "ust"
            @errors = @cafe.unselect_table()
        when "order"
            @errors = @cafe.order(uString[1])
        when "unorder"
            @errors = @cafe.unorder(uString[1])
        when "vieworder", "vo"
            @errors = @cafe.view_order()
        when "menu"
            @errors = @cafe.view_menu()
        when "additem", "addi"
            @errors = @cafe.add_item(uString[1], uString[2])
        when "removeitem", "remi"
            @errors = @cafe.remove_item(uString[1])
        when "saveitems"
            @errors = @cafe.save_items()
        when "bill", "pay"
            @errors = @cafe.bill(uString[1])
        when "cleartable", "clear"
            @errors = @cafe.clear_table()
        when "cash", "bank"
            @errors = @cafe.cash()
        when "help"
            self.printHelp
        when "exit", "close", "closecafe"
            puts "Adios!"
            @running = false
        else
            puts "'#{uString[0]}' is not a recognised command..."
            self.printHelp
        end

        if @errors
            if @errors.is_a? Float
                puts "£#{@errors}"
            elsif @errors.is_a? Array
                if @errors[0].is_a? Item
                    puts "******************"
                    @errors.each { |a|
                        print "#{a.name} £#{a.price}"
                        if a.gluten_free
                            print " (G)"
                        end
                        if a.vegie
                            print " (V)"
                        end
                        print "\n"
                    }
                    puts "******************"
                else
                    puts "******"
                    for x in @errors
                        puts x
                    end
                    puts "******"
                end
            else
                puts "** #{@errors} **"
            end
        end
    end

    def printHelp
        puts "\nCafe CodeClan"
        puts "---------------"
        puts "settables | sett [x]      : sets up [x] number of tables in the cafe"
        puts "addtable | add            : adds a new table and will return the table number"
        puts "seattable | seat [x] [y]  : seats [y] number of people at table [x]"
        puts "selecttable | selt [x]    : selects the table [x] so that it can be modified"
        puts "viewselectedtable | vst   : returns the table number that is currently selected"
        puts "unselecttable | ust       : unselects the current table, you will have to select a new table"
        puts "order [x]                 : adds item [x] to the selected table's order"
        puts "unorder [x]               : revoves item [x] from the selected table's order"
        puts "vieworder | vo            : returns the selected tables order"
        puts "pay | bill [x=1]                 : returns the total cost of the meal, if splitting between parties state [x] or will default to 1 paying party"
        puts "menu                      : returns the menu of the items avaliable for order"
        puts "additem | addi [x] [p]    : adds a new item [x] and it's price [p] to the list of items avaliable for order"
        puts "removeitem | remi [x]     : removes item [x] from the list of items avaliable to order"
        puts "cleartable | clear        : clear the table and add the money from the bill to the Cafe cash"
        puts "savemenu                  : saves the menu to a text file, this will be loaded in on start up so you don't loose the items"
        puts "cash                      : returns the total cash brought in through all the tables that have been cleared"
        puts "help                      : prints out this menu"
        puts "exit | close : will close the programme and the cafe"
    end


end
