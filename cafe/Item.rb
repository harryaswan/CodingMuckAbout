class Item

    attr_accessor( :name, :price, :gluten_free, :vegie )

    def initialize(name, price, gluten_free=false, vegie=false)
        @name = name
        @price = price.to_f
        @gluten_free = gluten_free
        @vegie = vegie
    end

    def to_csv
        return "#{@name},#{@price},#{@gluten_free},#{@vegie}"

    end

    def to_h()
        return {name: @name, price: @price, gluten_free: @gluten_free, vegie: @vegie}
    end
end
