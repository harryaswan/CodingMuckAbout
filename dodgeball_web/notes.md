# Dodgeball League

```
League <----------- Match
  ^
  |
  |
  |
  |
Team <--------- Player
  ^
  |
  |
Coach

```

---

Team
        - Name
        - Location
        - ID
        - matches() - pass true for games played only, false for games not played, nil for all games

Match
        - Away_Team_ID
        - Home_Team_ID
        - Winning_team_id
        - ID
        - winner() - returns the id of the team that won the game
        - get_vs() - returns a string of "<TEAM1.name> vs <TEAM2.name>"

League  - team_total_wins(team_id)
        - league_standing()
        - generate_matches()

Player  - Name
        - Position
        - Team_id
        - ID
        - ????

Coach   - Name
        - Team_id

---
