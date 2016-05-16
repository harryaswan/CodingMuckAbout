require("minitest/autorun")
require("minitest/rg")
require_relative("../models/coach")

class TestCoach < Minitest::Test

    def setup()
        @coach = Coach.new({'name'=>'Colin Somebody', 'team_id'=>'1', 'id'=>'1'})
    end
    def test_coach_id()
        test_result = @coach.id
        expected_result = 1
        assert_equal(expected_result,test_result)
    end
    def test_coach_name()
        test_result = @coach.name
        expected_result = "Colin Somebody"
        assert_equal(expected_result,test_result)
    end
    def test_coach_location()
        test_result = @coach.team_id
        expected_result = 1
        assert_equal(expected_result,test_result)
    end

end
