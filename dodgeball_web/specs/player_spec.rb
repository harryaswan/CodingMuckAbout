require("minitest/autorun")
require("minitest/rg")
require_relative("../models/player")

class TestPlayer < Minitest::Test

    def setup()
        @player = Player.new({'name'=>'Ronald McDonald', 'position'=>'Thrower', 'team_id'=>'1', 'id'=>'1'})
    end

    def test_player_id()
        test_result = @player.id
        expected_result = 1
        assert_equal(expected_result,test_result)
    end

    def test_player_name()
        test_result = @player.name
        expected_result = "Ronald McDonald"
        assert_equal(expected_result,test_result)
    end

    def test_player_team_id()
        test_result = @player.team_id
        expected_result = 1
        assert_equal(expected_result,test_result)
    end

    def test_player_position()
        test_result = @player.position
        expected_result = "Thrower"
        assert_equal(expected_result,test_result)
    end


end
