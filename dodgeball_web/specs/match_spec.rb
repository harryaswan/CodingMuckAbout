require("minitest/autorun")
require("minitest/rg")
require_relative("../models/team")
require_relative("../models/match")

class TestMatch < Minitest::Test

    def setup()
        @match = Match.new({'id'=>'1', 'home_team_id'=>1, 'away_team_id'=>2, 'winning_team'=>2})
    end
    def test_match_id()
        test_result = @match.id
        expected_result = 1
        assert_equal(expected_result,test_result)
    end
    def test_match_home_team()
        test_result = @match.home_team
        expected_result = 1
        assert_equal(expected_result,test_result)
    end

    def test_match_away_team()
        test_result = @match.away_team
        expected_result = 2
        assert_equal(expected_result,test_result)
    end

    def test_match_get_winning_team_id
        test_result = @match.winner
        expected_result = 2
        assert_equal(expected_result,test_result)
    end

    def test_match_get_vs()
        test_result = @match.get_vs
        expected_result = "The Bouncy Hoppers VS Devils of Dodge Kitchen"
        assert_equal(expected_result,test_result)
    end

end
