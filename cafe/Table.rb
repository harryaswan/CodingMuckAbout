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
        # @order.viewAllItems.each { |a|
        #     total += items[a]
        # }
        for i in @order.viewAllItems
            total += i.price
        end
        return total/ppl.round(2)
    end

end
