class League

    attr_reader(:teams, :matches)
    def initialize(teams)
        @teams = teams
    end

    def get_team(id)
        for t in @teams
            return t if t.id == id
        end
        return nil
    end

    def no_of_teams()
        return @teams.length
    end

    def team_total_wins(team_id)
        sql = "SELECT COUNT(*) FROM matches WHERE winning_team = #{team_id.to_i};"
        return SQLRun.exec(sql)[0]['count'].to_i
    end

    def team_total_looses(team_id)
        sql = "SELECT COUNT(*) FROM matches WHERE (home_team = #{team_id} OR away_team = #{team_id}) AND winning_team <> #{team_id} AND winning_team <> 0;"
        return SQLRun.exec(sql)[0]['count'].to_i
    end

    def game_board()
        return @matches.map {|m| m.get_vs() }
    end

    def play_game(home_team, away_team, winning_team)
        @matches.each do |m|
            if m.home_team == home_team && m.away_team == away_team
                m.winner = winning_team
            end
        end
    end

    def table
        # league_table = [] #[team_name, wins, looses]
        league_table = @teams.map {|team| [team.name, team_total_wins(team.id), team_total_looses(team.id)]}

        return league_table.sort {|x,y| y[1] <=> x[1]}
    end

    def get_matches()
        @matches = Match.all()
    end

    def create_matches()
        Match.delete_all()
        matches = []
        @teams.each do |team1|
            for team2index in (@teams.index(team1)+1...@teams.length)
                team2 = @teams[team2index]
                matches << Match.new({'home_team'=>team1.id, 'away_team'=>team2.id, 'winning_team'=>0}).save()
                matches << Match.new({'home_team'=>team2.id, 'away_team'=>team1.id, 'winning_team'=>0}).save()
            end
        end
        @matches = matches
    end

end
