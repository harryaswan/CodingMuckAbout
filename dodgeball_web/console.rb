require('pry-byebug')
require_relative('db/sql_runner')
require_relative('models/team')
require_relative('models/match')
require_relative('models/league')
require_relative('models/player')
require_relative('models/coach')

Match.delete_all()
Coach.delete_all()
Player.delete_all()
Team.delete_all()

teams = []
teams << Team.new({'name'=>'The Bouncy Hoppers', 'location'=>'New York'}).save()
teams << Team.new({'name'=>'Devil Dogs', 'location'=>'Texas'}).save()
teams << Team.new({'name'=>'Hard Throwers', 'location'=>'Florida'}).save()

players = []
players << Player.new({'name'=>'Player1', 'team_id'=>teams[0].id}).save()
players << Player.new({'name'=>'Player2', 'team_id'=>teams[0].id}).save()
players << Player.new({'name'=>'Player3', 'team_id'=>teams[1].id}).save()
players << Player.new({'name'=>'Player4', 'team_id'=>teams[1].id}).save()
players << Player.new({'name'=>'Player5', 'team_id'=>teams[2].id}).save()
players << Player.new({'name'=>'Player6', 'team_id'=>teams[2].id}).save()

coaches = []
coaches << Coach.new({'name'=>'Dave', 'team_id'=>teams[0].id}).save()
coaches << Coach.new({'name'=>'Colin', 'team_id'=>teams[1].id}).save()
coaches << Coach.new({'name'=>'James', 'team_id'=>teams[2].id}).save()

league = League.new(teams)


binding.pry
nil
