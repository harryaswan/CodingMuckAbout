class Item

    attr_accessor( :name, :price, :gluten_free, :vegie )

    def initialize(name, price, gluten_free=false, vegie=false)
        @name = name
        @price = price.to_f
        @gluten_free = gluten_free
        @vegie = vegie

        # ADD IN: a glutenFree & vegie bool's
        # => print a G or a V next to the item in the menu

        # @items = {
        #     pizza: 4.99,
        #     steak_pie: 6.99,
        #     pasta: 7.99,
        #     cola: 1.99,
        #     lemonade: 1.99,
        #     water: 0.00
        # }
        # menu[0] = Item.new(:pizza, 4.99)
    end

    def to_h()
        return {name: @name, price: @price, gluten_free: @gluten_free, vegie: @vegie}
    end

    # def getItems()
    #     @items
    # end
    # def add(item, price)
    #     @items[item] = price
    # end
    # def delete(item)
    #     @items.delete(item)
    # end

end
