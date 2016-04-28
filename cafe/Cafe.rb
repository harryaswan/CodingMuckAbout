class Cafe
    def initialize
        @selected_table = nil
        @tables = []
        @menu = Menu.new
        @cash = 0.00
        create_items()
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
        if num == ""
            num = @selected_table
        else
            num = num.to_i
        end
        if num < @tables.length
            if ppl.to_i == 0
                ppl = 1
            end
            @tables[num].new(ppl.to_i)
            return "Table #{num} has been seated with #{ppl} customer(s)"
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

    def order(item_as_string="pizza")
        if @selected_table

            if item_avaliable = @menu.has(item_as_string)
                @tables[@selected_table].order(item_avaliable)
            else
                return "The item you have tried to order does not exist yet"
            end

        else
            return "You must select a table first..."
        end
    end

    def unorder(item_as_string)
        if @selected_table
            if tmp_item = @menu.has(item_as_string)
                @tables[@selected_table].unorder(tmp_item)
            else
                return "Sorry, can't seem to find that item"
            end
        else
            return "You must select a table first..."
        end
    end

    def view_order()

        if @selected_table
            order_string = "\n"
            @tables[@selected_table].view_ordered_items().each { |x| order_string << "* #{x.name.to_s} --- #{x} \n"}
            return order_string
        else
            return "You must select a table first..."
        end

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

    def view_menu()
        @menu.get_items()
    end

    def add_item(name, price, glu=false, veg=false)
        @menu.add_item(Item.new(name, price.to_f, glu, veg))
    end

    def remove_item(item)
        @menu.remove_item(item)
    end

    def create_items() #temp - will load in from file

        @menu.add_item(Item.new("Pizza", "4.99"))
        @menu.add_item(Item.new("Cola", "1.99"))
        @menu.add_item(Item.new("Water", "0.00", true, true))

    end
end
