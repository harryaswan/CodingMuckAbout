class Match

    attr_reader(:id, :home_team, :away_team)
    def initialize(opts)
        @id = opts['id'].to_i
        @home_team = opts['home_team'].to_i
        @away_team = opts['away_team'].to_i
        @winning_team = opts['winning_team'].to_i
    end

    def winner()
        return @winning_team
    end

    def winner=(winning_team)
        @winning_team = winning_team.to_i()
        puts "mid: #{@id}"
        sql = "UPDATE matches SET winning_team = #{@winning_team} WHERE id = #{@id} RETURNING *;"
        SQLRun.exec(sql)[0]
    end

    def played?
        return @winning_team != 0 ? true : false
    end

    def get_vs()
        sql1 = "SELECT * FROM teams WHERE id = #{@home_team};"
        sql2 = "SELECT * FROM teams WHERE id = #{@away_team};"
        h_t = Team.create(sql1, false)
        a_t = Team.create(sql2, false)
        return "#{h_t.name} VS #{a_t.name}"
    end

    def save()
        if @id == 0
            sql = "INSERT INTO matches (home_team, away_team, winning_team) VALUES (#{@home_team}, #{@away_team}, #{@winning_team}) RETURNING *;"
        end
        return Match.create(sql, false)
    end

    def self.all()
        sql = "SELECT * FROM matches;"
        return Match.create(sql)
    end
    def self.delete_all()
        sql = "DELETE FROM matches;"
        SQLRun.exec(sql)
        return nil
    end

    def self.create(sql, multi=true)
        res = SQLRun.exec(sql)
        mch = res.map {|r| Match.new(r)}
        return multi ? mch : mch.first
    end

end
