DROP TABLE coaches;
DROP TABLE players;
DROP TABLE teams CASCADE;
DROP TABLE matches;


CREATE TABLE teams (
    id SERIAL4 PRIMARY KEY,
    name VARCHAR(255),
    location VARCHAR(255)
);

CREATE TABLE coaches (
    id SERIAL4 PRIMARY KEY,
    name VARCHAR(255),
    team_id INT4 REFERENCES teams(id) UNIQUE
);

CREATE TABLE players (
    id SERIAL4 PRIMARY KEY,
    name VARCHAR(255),
    position VARCHAR(255),
    team_id INT4 REFERENCES teams(id)
);

CREATE TABLE matches (
    id SERIAL4 PRIMARY KEY,
    home_team INT4 REFERENCES teams(id),
    away_team INT4 REFERENCES teams(id),
    winning_team INT4,
    CHECK (home_team <> away_team)
    --CHECK (winning_team = home_team OR winning_team = away_team)
);
