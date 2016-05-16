require("minitest/autorun")
require("minitest/rg")
require_relative("../models/team")
require_relative("../models/match")
require_relative("../models/league")
class TestLeague < Minitest::Test

    def setup()
        teams = [Team.new({'name'=>'The Bouncy Hoppers', 'location'=>'Texas', 'id'=>'1'}), Team.new({'name'=>'Devils of Dodge Kitchen', 'location'=>'New York', 'id'=>'2'})]
        @league = League.new(teams)
    end
    def test_number_of_teams()
        test_result = @league.teams
        expected_result = 2
        assert_equal(expected_result,test_result)
    end
    def test_team_total_wins()
        test_result = @league.team_total_wins(1)
        expected_result = "??"
        assert_equal(expected_result,test_result)
    end

end
