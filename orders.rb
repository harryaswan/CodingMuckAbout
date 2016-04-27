require_relative("console.rb")

class CafeConsole < ConsoleUI

    def initialize
        @running = true
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
            puts "** #{@errors} **"
        end

    end


end

class Cafe
    def initialize
        @selected_table = nil
        @tables = []
        @items = Items.new
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
        if (num)
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
            @tables[@selected_table].order(item)
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

        return order_string << "\n"

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

    def pay(ppl)

    end

    def clear_table()

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
        @items.delete(old_item)
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

con = CafeConsole.new()
con.start
