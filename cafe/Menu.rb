class Menu

    def initialize
        @items = []
    end

    def add_item( item )
        @items << item
    end

    def remove_item(item_as_string)
        if tmp = has(item_as_string)
            @items.delete(tmp)
        end
    end

    def get_items()
        return @items
    end

    def to_s

        full_menu = "***** Cafe CodeClan Menu *****"

        for item in @items
            full_menu << "\n#{item.name} #{item.price}"
        end

        return full_menu

    end

    def has(item_as_string)
        for item in @items.reverse
            if item.name.downcase == item_as_string.downcase
                puts "i: #{item}"
                return item
            end
        end
        return false
    end

end
