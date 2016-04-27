require_relative("console.rb")

class CafeConsole < ConsoleUI

    def initialize
        super()
        @cafe = Cafe.new
        @errors = nil
    end

    def in(uString)

        @errors = nil
        uString = uString.split(" ")

        case uString[0]
        when "settables", "sett"
            @errors = @cafe.set_tables(uString[1].to_i)
        when "addtable", "add"
            @errors = @cafe.add_table()
        when "seattable", "seat"
            @errors = @cafe.seat_table(uString[1].to_i, uString[2].to_i)
        when "selecttable", "selt"
            @errors = @cafe.select_table(uString[1].to_i)
        when "viewselectedtable", "vst"
            @errors = @cafe.view_selected_table()
        when "unselecttable", "ust"
            @errors = @cafe.unselect_table()
        when "order"
            @errors = @cafe.order(uString[1].to_sym)
        when "unorder"
            @errors = @cafe.unorder(uString[1].to_sym)
        when "vieworder", "vo"
            @errors = @cafe.view_order()
        when "items"
            @errors = @cafe.items_avaliable()
        when "additem", "addi"
            @errors = @cafe.add_item(uString[1].to_sym, uString[2].to_f)
        when "removeitem", "remi"
            @errors = @cafe.remove_item(uString[1].to_sym)
        when "pay"
            @errors = @cafe.pay(uString[1])
        when "cleartable", "clear"
            @errors = @cafe.clear_table(uString[1])
        when "cash"
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
            if @errors.is_a? Hash
                puts "******"
                @errors.each { |f, c| puts "#{f} £#{c}" }
                puts "******"
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
        puts "items                     : returns a list of the items avaliable for order"
        puts "additem | addi [x] [p]    : adds a new item [x] and it's price [p] to the list of items avaliable for order"
        puts "removeitem | remi [x]     : removes item [x] from the list of items avaliable to order"
        puts "pay [x=1]                 : returns the total cost of the meal, if splitting between parties state [x] or will default to 1 paying party"
        puts "cleartable | clear        : clear the table and add the money from the bill to the Cafe cash"
        puts "cash                      : returns the total cash brought in through all the tables that have been cleared"
        puts "help                      : prints out this menu"
        puts "exit | close : will close the programme and the cafe"
    end


end

class Cafe
    def initialize
        @selected_table = nil
        @tables = []
        @items = Items.new
        @cash = 0.00
    end

    def set_tables(num)
        num.times { @tables.push(Table.new(@tables.length))}
        return "#{num} tables have been set up."
    end

    def add_table()
        @tables.push(Table.new(@tables.length))
        return "A new table has been added, it is Table #{@tables.length - 1}"
    end

    def seat_table(num, ppl)
        if num < @tables.length
            @tables[num].new(ppl)
            return "Table #{num} has been seated with #{ppl} people"
        else
            return "Sorry but table #{num} has not been setup...\nTry adding the table to the cafe first"
        end
    end

    def select_table(num)
        if (num < @tables.length)
            @selected_table = num
        else
            return "Please ensure you enter a table number"
        end
    end

    def unselect_table()
        @selected_table = nil
    end

    def view_selected_table()
        return @selected_table ? "Table #{@selected_table} is currently selected" : "No table is currently selected"
    end

    def order(item)
        if @selected_table
            if (items_avaliable().key?(item))
                @tables[@selected_table].order(item)
            else
                return "The item you have tried to order has not been created... try additem first"
            end
        else
            return "You must select a table first..."
        end
    end

    def unorder(item)
        if @selected_table
            @tables[@selected_table].unorder(item)
        else
            return "You must select a table first..."
        end
    end

    def view_order()

        order_string = "\n"

        @tables[@selected_table].view_ordered_items().each { |x| order_string << "* #{x.to_s} \n"}

        return order_string

    end

    def pay(ppl)
        if ppl == "" || ppl.to_i == 0
            ppl = 1
        end

        return @tables[@selected_table].pay(ppl.to_i, items_avaliable())
    end

    def clear_table(paid=true)
        if @selected_table
            cash_in(pay(1))
            return cash()
        else
            return "Please select a table to clear"
        end
    end

    def cash()
        return @cash
    end
    def cash_in(amt)
        @cash += amt
        return @cash
    end
    def cash_out(amt)
        @cash -= amt
        return @cash
    end

    def items_avaliable()
        @items.getItems()
    end

    def add_item(item, price)
        @items.add(item, price)
    end

    def remove_item(item)
        @items.delete(item)
    end
end
class Table

    def initialize(id) # , max_ppl)
        @table = id
        # @max_people = max_ppl
        @sitting = 0
        @order = nil
    end

    def new(num_people)
        @sitting = num_people
        @order = Order.new()
    end
    def order(item)
        if @order
            @order.addItem(item)
        else
            return "The table has not been seated...."
        end
    end
    def unorder(item)
        if @order
            @order.removeItem(item)
        else
            return "The table has not been seated...."
        end
    end

    def view_ordered_items()
        return @order.viewAllItems()
    end

    def pay(ppl, items)
        total = 0
        @order.viewAllItems.each { |a|
            total += items[a]
        }
        return total/ppl.round(2)
    end

end
class Order

    def initialize() # , people)
        # @order_id = id
        # @num_people = people
        @items = []
    end
    def addItem(new_item)
        @items.push(new_item)
    end
    def removeItem(old_item)
        @items.delete_at(@items.index(old_item))
    end
    def viewAllItems()
        return @items
    end
    # def getId()
    #     return @order_id
    # end

end
class Items

    def initialize
        @items = {
            pizza: 4.99,
            steak_pie: 6.99,
            pasta: 7.99,
            cola: 1.99,
            lemonade: 1.99,
            water: 0.00
        }
    end
    def getItems()
        @items
    end
    def add(item, price)
        @items[item] = price
    end
    def delete(item)
        @items.delete(item)
    end

end

puts "\nWelcome to Cafe CodeClan..."

con = CafeConsole.new()
con.start
