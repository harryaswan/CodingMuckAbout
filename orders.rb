class Order

    def initialize(id, people)
        @order_id = id
        @num_people = people
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


end
