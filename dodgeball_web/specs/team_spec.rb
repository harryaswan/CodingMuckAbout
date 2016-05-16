require("minitest/autorun")
require("minitest/rg")
require_relative("../models/team")

class TestTeam < Minitest::Test

    def setup()
        @team = Team.new({'name'=>'The Bouncy Hoppers', 'location'=>'New York', 'id'=>'1'})
    end
    def test_team_id()
        test_result = @team.id
        expected_result = 1
        assert_equal(expected_result,test_result)
    end
    def test_team_name()
        test_result = @team.name
        expected_result = "The Bouncy Hoppers"
        assert_equal(expected_result,test_result)
    end
    def test_team_location()
        test_result = @team.location
        expected_result = "New York"
        assert_equal(expected_result,test_result)
    end

end
