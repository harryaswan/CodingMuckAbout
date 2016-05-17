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
    if params[:error]
        @error = error_code(params[:error])
    end
    erb(:teams)
end

get '/team/:id' do
    if params[:id]
        id = params[:id].to_i()
        league = League.new(Team.all())
        @team = league.get_team(id)
        table = league.table()
        puts "TEAM: #{@team}"
        if @team
            for t in table
                @wins = t if t[0] == @team.name
            end
            erb(:team)
        else
            redirect '/teams'
        end
    else
        redirect '/teams'
    end
end

get '/players' do
    @players = Player.all()
    if params[:error]
        @error = error_code(params[:error])
    end
    # @teams = Team.all()
    erb(:players)
end

get '/player/:id' do
    if params[:id]
        id = params[:id].to_i()
        players = Player.all()
        for i in players
            @player = i if i.id == id
        end
        if @player
            league = League.new(Team.all())
            @team = league.get_team(@player.team_id)
            erb(:player)
        else
            redirect '/players'
        end
    else
        redirect '/players'
    end
end

get '/coaches' do
    @coaches = Coach.all()
    if params[:error]
        @error = error_code(params[:error])
    end
    erb(:coaches)
end

get '/coach/:id' do
    if params[:id]
        id = params[:id].to_i()
        coaches = Coach.all()
        for i in coaches
            @coach = i if i.id == id
        end
        if @coach
            league = League.new(Team.all())
            @team = league.get_team(@coach.team_id)
            erb(:coach)
        else
            redirect '/coaches'
        end
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

post '/teams' do
    if params[:name] != "" && params[:location] != ""
        name = params[:name]
        location = params[:location]
        team = Team.new({'name'=>name, 'location'=>location}).save
        if team.id != 0
            redirect '/team/' + team.id.to_s()
        else
            redirect '/teams?error=2'
        end
    else
        redirect '/teams?error=1'
    end
end

post '/players' do
    if params[:name] != "" && params[:position] != "" && params[:team_id] != "nil"
        name = params[:name]
        position = params[:position]
        team_id = params[:team_id]
        player = Player.new({'name'=>name, 'position'=>position, 'team_id'=>team_id}).save()
        if player.id != 0
            redirect '/player/' + player.id.to_s()
        else
            redirect '/players?error=2'
        end
    else
        redirect '/players?error=1'
    end
end

post '/coaches' do
    if params[:name] != "" && params[:team_id] != "nil"
        name = params[:name]
        team_id = params[:team_id]
        player = Coach.new({'name'=>name, 'team_id'=>team_id}).save()
        if player.id != 0
            redirect '/coach/' + player.id.to_s()
        else
            redirect '/coaches?error=2'
        end
    else
        redirect '/coaches?error=1'
    end
end


post '/coach/:id' do
    if params[:coach_id] != "" && params[:delete_coach]
        if params[:id] == params[:coach_id]
            puts "DELETE COACH FROM DB"
        else
            puts "Nope"
        end
    end
end


def error_code(code="none")
    case (code)
    when "1"
        return "You must enter all required inputs"
    when "2"
        return "There was an issue saving, try again."
    end
    return "There was an issue making the requested action"
end
