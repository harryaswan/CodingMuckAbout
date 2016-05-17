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


# **** GETS ****

get '/' do
    league = League.new(Team.all())
    league.get_matches()
    if league.matches.length > 0
        @vs_board = league.game_board()
        @played = []
        @ids = []
        for x in (0...@vs_board.length)
            # puts "[ test= #{league.matches[x]}]"
            @ids << {h_id: league.matches[x].home_team, a_id: league.matches[x].away_team}
            @played << league.matches[x].played?
        end
        @table = league.table()
    end
    erb(:index)
end

get '/teams' do
    @teams = Team.all()
    erb(:teams)
end

get '/team/:id' do
    if params[:id]
        id = params[:id].to_i()
        league = League.new(Team.all())
        @team = league.get_team(id)
        table = league.table()
        for t in table
            @wins = t if t[0] == @team.name
        end
        erb(:team)
    end
end

get '/players' do
    @players = Player.all()
    erb(:players)
end

get '/player/:id' do
    if params[:id]
        id = params[:id].to_i()
        players = Player.all()
        for i in players
            @player = i if i.id == id
        end
        league = League.new(Team.all())
        @team = league.get_team(@player.team_id)
        erb(:player)
    else
        redirect '/players'
    end
end

get '/coaches' do
    @coaches = Coach.all()
    erb(:coaches)
end

get '/coach/:id' do
    if params[:id]
        id = params[:id].to_i()
        coaches = Coach.all()
        for i in coaches
            @coach = i if i.id == id
        end
        league = League.new(Team.all())
        @team = league.get_team(@coach.team_id)
        erb(:coach)
    else
        redirect '/coaches'
    end
end

# get '/play/:home/:away/:win' do
#     league = League.new(Team.all())
#     if request.cookies['notFirstTime']
#         league.set_matches()
#     else
#         response.set_cookie("notFirstTime", "true")
#         league.create_matches()
#     end
#     home = params[:home].to_i()
#     away = params[:away].to_i()
#     win = params[:win].to_i()
#     if win == home || win == away
#         league.play_game(home, away, win)
#         redirect '/'
#     end
#
# end


# ***** POSTS *****

post '/' do
    if params[:reset]
        Match.delete_all()
        # response.delete_cookie("notFirstTime")
    elsif params[:create]
        league = League.new(Team.all())
        league.create_matches()
    end
    redirect '/'
end

post '/play' do
    if params[:home] || params[:away]
        puts params
        league = League.new(Team.all())
        # if request.cookies['notFirstTime']
        league.get_matches()
        if league.matches.length > 0
            # else
            #     response.set_cookie("notFirstTime", "true")
            #     league.create_matches()
            # end
            h_a = params[:h_a].split(",")
            home = h_a[0].to_i()
            away = h_a[1].to_i()
            win = params[:home] ? h_a[0].to_i() : h_a[1].to_i()
            if win == home || win == away
                league.play_game(home, away, win)
            end
        end
        redirect '/'
    end
end
