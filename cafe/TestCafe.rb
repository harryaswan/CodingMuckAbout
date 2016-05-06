require('minitest/autorun')
#require_relative("CafeConsole")
require_relative("ConsoleUI")
require_relative("Cafe")
require_relative("Table")
require_relative("Order")
require_relative("Menu")
require_relative("Item")

class Functions_Practice < MiniTest::Test



    def test_something
        test_result = some_test()
        actual_result = "answer"
        assert_equal(actual_result,test_result)
    end
end
