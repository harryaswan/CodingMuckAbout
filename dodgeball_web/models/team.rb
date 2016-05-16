class Team

    attr_reader(:id, :name, :location)
    def initialize(opts)
        @id = opts['id'].to_i
        @name = opts['name']
        @location = opts['location']
    end

    def matches(played = nil)
        sql = "SELECT * FROM matches WHERE (home_team = #{@id} OR away_team = #{@id})"
        if played.nil?
            sql << ";"
        elsif played
            sql << " AND winning_team <> 0;"
        else
            sql << " AND winning_team = 0;"
        end
        return Match.create(sql)
    end

    def players()
        sql = "SELECT * FROM players WHERE team_id = #{@id};"
        return Player.create(sql)
    end

    def coach()
        sql = "SELECT * FROM coaches WHERE team_id = #{@id};"
        return Coach.create(sql, false)
    end

    def save()
        # if @id == 0
            sql = "INSERT INTO teams (name, location) VALUES ('#{@name}', '#{@location}') RETURNING *;"
        # end
        return Team.create(sql, false)
    end

    def self.all()
        sql = "SELECT * FROM teams;"
        return Team.create(sql)
    end
    def self.delete_all()
        sql = "DELETE FROM teams;"
        SQLRun.exec(sql)
        return nil
    end

    def self.create(sql, multi=true)
        res = SQLRun.exec(sql)
        tm = res.map {|r| Team.new(r)}
        return multi ? tm : tm.first
    end

end
