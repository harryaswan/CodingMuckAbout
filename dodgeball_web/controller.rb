require("sinatra")
require("sinatra/contrib/all") if development?
require("json")
require("pry-byebug")
require_relative('db/sql_runner')
require_relative('models/team')
require_relative('models/match')
require_relative('models/league')
require_relative('models/player')
require_relative('models/coach')




get '/' do
    league = League.new(Team.all())
    @vs_board = league.game_board()
    @played = []
    @ids = []
    for x in (0...@vs_board.length)
        puts "[ test= #{league.matches[x]}]"
        @ids << {h_id: league.matches[x].home_team, a_id: league.matches[x].away_team}
        @played << league.matches[x].played?
    end
    erb(:index)
end

get '/play/:home/:away/:win' do
    league = League.new(Team.all())
    home = params[:home].to_i()
    away = params[:away].to_i()
    win = params[:win].to_i()
    if win == home || win == away
        league.play_game(home, away, win)
        redirect '/'
    end

end
