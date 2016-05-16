class Player

    attr_reader(:id, :name, :position, :team_id)
    def initialize(opts)
        @id = opts['id'].to_i
        @name = opts['name']
        @position = opts['position']
        @team_id = opts['team_id'].to_i
    end

    def team()
        sql = "SELECT * FROM teams WHERE id = #{@team_id};"
        return Team.create(sql, false)
    end

    def save()
        if @id == 0
            sql = "INSERT INTO players (name, position, team_id) VALUES ('#{@name}', '#{@position}', #{@team_id}) RETURNING *;"
        end
        return Player.create(sql, false)
    end

    def self.delete_all()
        sql = "DELETE FROM players;"
        SQLRun.exec(sql)
        return nil
    end

    def self.create(sql, multi=true)
        res = SQLRun.exec(sql)
        ply = res.map {|r| Player.new(r)}
        return multi ? ply : ply.first
    end

end
