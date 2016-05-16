require('pg')
class SQLRun

    def self.exec(sql)
        begin
            db = PG.connect({ dbname: 'dodgeball', host: 'localhost' })
            result = db.exec( sql )
        ensure
            db.close
        end
        return result
    end

end
