class Coach

    attr_reader(:id, :name, :team_id)
    def initialize(opts)
        @id = opts['id'].to_i
        @name = opts['name']
        @team_id = opts['team_id'].to_i
    end


    def team()
        sql = "SELECT * FROM teams WHERE id = #{@team_id};"
        return Team.create(sql, false)
    end

    def save()
        if @id == 0
            sql = "INSERT INTO coaches (name, team_id) VALUES ('#{@name}',#{@team_id}) RETURNING *;"
        end
        return Coach.create(sql, false)
    end

    def self.delete_all()
        sql = "DELETE FROM coaches;"
        SQLRun.exec(sql)
        return nil
    end

    def self.create(sql, multi=true)
        res = SQLRun.exec(sql)
        coa = res.map {|r| Coach.new(r)}
        return multi ? coa : coa.first
    end

end
