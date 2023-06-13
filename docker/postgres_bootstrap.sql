CREATE SCHEMA nba_prod;
SET search_path TO nba_prod;

-- boostrap script boiiiiiiiii
DROP TABLE IF EXISTS standings;
CREATE TABLE standings(
    rank text,
    team text,
    team_full text,
    conference text,
    wins bigint,
    losses bigint,
    games_played bigint,
    win_pct numeric,
    active_injuries numeric,
    active_protocols numeric,
    last_10 text
);

INSERT INTO standings (rank, team, team_full, conference, wins, losses, games_played, win_pct, active_injuries, active_protocols, last_10)
VALUES ('1st', 'MIL', 'Milwaukee Bucks', 'Eastern', 57, 22, 79, 0.722, 3, 0, '7-3'),
       ('2nd', 'BOS', 'Boston Celtics', 'Eastern', 54, 25, 79, 0.684, 4, 0, '7-3');

DROP TABLE IF EXISTS scorers;
CREATE TABLE scorers(
    player text,
    team text,
    full_team text,
    season_avg_ppg numeric,
    playoffs_avg_ppg numeric,
    season_ts_percent numeric,
    playoffs_ts_percent numeric,
    games_played bigint,
    playoffs_games_played bigint,
    ppg_rank bigint,
    top20_scorers text,
    player_mvp_calc_adj numeric,
    games_missed bigint,
    penalized_games_missed numeric,
    top5_candidates text,
    mvp_rank bigint
);

INSERT INTO scorers (player, team, full_team, season_avg_ppg, playoffs_avg_ppg, season_ts_percent, playoffs_ts_percent, games_played, playoffs_games_played,
                          ppg_rank, top20_scorers, player_mvp_calc_adj, games_missed, penalized_games_missed, top5_candidates, mvp_rank)
VALUES ('Nikola Jokic', 'DEN', 'Denver Nuggets', 24.8, null, 0.702, null, 68, null, 23, 'Other', 48.70, 11, 0, 'Top 5 MVP Candidate', 1),
       ('Shai Gilgeous-Alexander', 'OKC', 'Okalahoma City Thunder', 31.5, null, 0.628, null, 67, null, 4, 'Top 20 Scorers', 44.10, 13, 0,
        'Top 5 MVP Candidate', 5);

DROP TABLE IF EXISTS team_ratings;
CREATE TABLE team_ratings(
    team text,
    team_acronym text,
    w integer,
    l integer,
    ortg numeric,
    drtg numeric,
    nrtg numeric,
    team_logo text,
    nrtg_rank text,
    drtg_rank text,
    ortg_rank text
);

INSERT INTO team_ratings (team, team_acronym, w, l, ortg, drtg, nrtg, team_logo, nrtg_rank, drtg_rank, ortg_rank)
VALUES ('Boston Celtics', 'BOS', 54, 25, 118, 111.6, 6.4, 'logos/bos.png', '1st', '3rd', '2nd'),
       ('Cleveland Cavaliers', 'CLE', 50, 30, 116.4, 110.8, 5.6, 'logos/cle.png', '2nd', '1st', '8th');

DROP TABLE IF EXISTS twitter_comments;
CREATE TABLE twitter_comments(
    created_at date,
    scrape_ts timestamp without time zone,
    username text,
    tweet text,
    url text,
    likes numeric,
    retweets numeric,
    compound numeric,
    neg numeric,
    neu numeric,
    pos numeric
);

INSERT INTO twitter_comments (created_at, scrape_ts, username, tweet, url, likes, retweets, compound, neg, neu, pos)
VALUES (current_date, current_timestamp, 'KingJames', 'Man thats SIMPLY INSANE!!!! 🤣🤣🤣🤣🤣🤣🤣🤣🤣 https://t.co/WqyIWKHs4T',
        'https://twitter.com/twitter/statuses/1640515719896141826', 205431, 12757, 0, 0, 1, 0),
       (current_date, current_timestamp, 'FOS', 'The NCAA Womens National Championships 9.9 million viewers are more than',
        'https://twitter.com/twitter/statuses/1643051889846525953', 205431, 12757, 0, 0, 1, 0);

DROP TABLE IF EXISTS reddit_comments;
CREATE TABLE reddit_comments(
    scrape_date date,
    author text,
    comment text,
    flair text,
    score bigint,
    url text,
    compound numeric,
    pos numeric,
    neu numeric,
    neg numeric
);

INSERT INTO reddit_comments (scrape_date, author, comment, flair, score, url, compound, pos, neu, neg)
VALUES (current_date, 'rattatatouille', 'Jokic putting up a dismal effort', 'Spurs', 5875, 
        'https://www.reddit.com/r/nba/comments/12c4y8y/nikola_jokic_disasterclass_against_houston_14/',
        -0.6124, 0, 0.846, 0.154),
       (current_date, 'KaiserKaiba', 'NBA scriptwriters working overtime right now', null, 2829,
        'https://www.reddit.com/r/nba/comments/12c4y8y/nikola_jokic_disasterclass_against_houston_14/',
        0, 0, 1, 0);

DROP TABLE IF EXISTS injuries;
CREATE TABLE injuries(
    injury_pk text,
    player text,
    team_acronym text,
    team text,
    date text,
    status text,
    injury text,
    description text,
    total_injuries bigint,
    team_active_injuries numeric,
    team_active_protocols numeric,
    scrape_date date
);

INSERT INTO injuries (injury_pk, player, team_acronym, team, date, status, injury, description,
                           total_injuries, team_active_injuries, team_active_protocols, scrape_date)
VALUES ('09a97226ecd7b666dd516039ce752720', 'Myles Turner', 'IND', 'Indiana Pacers', 'Tues, Apr 4, 2023',
        'Day to Day', 'Ankle/Back', 'Turner is questionable for Wednesdays (Apr.5) game against New York.', 4, 4, 0, current_date),
       ('0e6fe518fdecea9c84ad54608810a528', 'Tyrese Haliburton', 'Haliburton is out for Wednesdays (Apr.5) game against New York.',
        'IND', 'Indiana Pacers', 'Tues, Apr 4, 2023', 'Out', 'Ankle', 4, 4, 0, current_date);

DROP TABLE IF EXISTS game_types;
CREATE TABLE game_types(
    game_type text,
    type text,
    n bigint,
    explanation text
);

INSERT INTO game_types (game_type, type, n, explanation)
VALUES ('20 pt Game', 'Regular Season', 356, 'between 11 and 20 points'),
       ('Blowout Game', 'Regular Season', 154, 'more than 20 points'),
       ('10 pt Game', 'Regular Season', 351, 'between 6 and 10 points'),
       ('Clutch Game', 'Regular Season', 327, '5 points or less');

DROP TABLE IF EXISTS feedback;
CREATE TABLE feedback(
    id serial primary key,
    feedback character varying,
    time timestamp without time zone
);

DROP TABLE IF EXISTS schedule;
CREATE TABLE schedule(
    date date,
    day text,
    avg_team_rank bigint,
    start_time text,
    home_team text,
    away_team text,
    home_moneyline_raw numeric,
    away_moneyline_raw numeric
);

INSERT INTO schedule (date, day, avg_team_rank, start_time, home_team, away_team, home_moneyline_raw, away_moneyline_raw)
VALUES (current_date, 'Monday', 16, '7:00 PM', 'Indiana Pacers', 'New York Knicks', 300, -365),
       (current_date, 'Monday', 20, '7:00 PM', 'New York Knicks', 'Indiana Pacers', -365, 300);

DROP TABLE IF EXISTS nba_predictions;
CREATE TABLE nba_predictions(
    proper_date date,
    home_team text,
    home_team_odds double precision,
    home_team_predicted_win_pct numeric,
    away_team text,
    away_team_odds double precision,
    away_team_predicted_win_pct numeric
);

INSERT INTO nba_predictions (proper_date, home_team, home_team_odds, home_team_predicted_win_pct, away_team, away_team_odds, away_team_predicted_win_pct)
VALUES (current_date, 'Indiana Pacers', '+200', 0.247, 'San Antonio Spurs', '-160', 0.753),
       (current_date, 'Houston Rockets', '-140', 0.194, 'Memphis Grizzlies', '+180', 0.806),
       (current_date, 'Golden State Warriors', '-150', 0.712, 'Boston Celtics', '180', 0.288),
       (current_date, 'Dallas Mavericks', '-140', 0.194, 'Detroit Pistons', '+180', 0.806),
       (current_date, 'Chicago Bulls', '+200', 0.355, 'Charlotte Hornets', '-160', 0.645),
       (current_date, 'Utah Jazz', '+320', 0.194, 'Phoenix Suns', '-250', 0.806);


DROP TABLE IF EXISTS transactions;
CREATE TABLE IF NOT EXISTS transactions
(
    date date,
    transaction text COLLATE pg_catalog."default"
);

INSERT INTO transactions(date, transaction)
VALUES (current_date, 'The Portland Trail Blazers signed Skylar Mays.'),
       (current_date, 'The Toronto Raptors fired Nick Nurse as Head Coach.');


DROP TABLE IF EXISTS rest_api_users;
CREATE TABLE IF NOT EXISTS rest_api_users
(
    id serial primary key,
    username text not null,
    password text not null,
    email text,
    salt text,
    created_at timestamp default now()
);

-- these users all have password as the actual "password"
INSERT INTO rest_api_users(username, password, salt, email)
VALUES ('jyablonski', 'db15bf237233df6654f39476884e8bb9', 'eylptjzw6tqy68zxg5b8v9l2bdwxsztf', 'j@yablonski.com'),
       ('test', '0b1bcb3aa21cc0325ccfec50ae77ee09', 'utwvsvfcofpanwtwt7u3tegwvnz5ey35', 'test@nobody.com'),
       ('test1', 'fc69b839fbcd8ecd2d9407406a9eec66', 'u61hred56dm6il2sgtws9m1k4704y3ph', 'test@nobody.com'),
       ('test2', '32b67f6dad97c4d009bab26dfbafbe27', 'cxfpyjvny5kro6phuxpchxlxg1c1stjw', 'test@nobody.com'),
       ('test3', '6c4dab6f6c721e9eb0ed908e8b7f7a06', 'lv1exd0c2tmfv414voo1716ggrpnk60f', 'test@nobody.com');


DROP TABLE IF EXISTS user_predictions;
CREATE TABLE IF NOT EXISTS user_predictions
(
    id serial primary key,
    username text,
    game_date date,
    home_team text COLLATE pg_catalog."default",
    home_team_odds integer,
    home_team_predicted_win_pct double precision,
    away_team text COLLATE pg_catalog."default",
    away_team_odds integer,
    away_team_predicted_win_pct double precision,
    selected_winner text COLLATE pg_catalog."default",
    bet_amount integer,
    created_at timestamp without time zone DEFAULT now()
);

-- 2023-05-28 update: this table is made from dbt in prod.  for testing im just making a blank table to test 
-- past bets functionality.
DROP TABLE IF EXISTS mov;
CREATE TABLE IF NOT EXISTS mov
(
    team text COLLATE pg_catalog."default",
    full_team text COLLATE pg_catalog."default",
    game_id bigint,
    date date,
    outcome text COLLATE pg_catalog."default",
    opponent text COLLATE pg_catalog."default",
    pts_scored numeric,
    pts_scored_opp numeric,
    mov numeric,
    record text COLLATE pg_catalog."default"
);

DROP TABLE IF EXISTS feature_flags;
CREATE TABLE IF NOT EXISTS feature_flags
(
	id serial primary key,
	flag text,
	is_enabled integer,
	created_at timestamp without time zone default now(),
	modified_at timestamp without time zone default now(),
    CONSTRAINT flag_unique UNIQUE (flag)
);
INSERT INTO feature_flags(flag, is_enabled)
VALUES ('season', 1),
       ('playoffs', 1);

create view user_past_predictions as
WITH home_wins AS (
    SELECT 
        mov.full_team AS home_team,
        mov.date AS game_date,
        mov.outcome
    FROM nba_prod.mov
    ),
    combo AS (
    SELECT 
        user_predictions.id,
        user_predictions.username,
        user_predictions.game_date,
        user_predictions.home_team,
        user_predictions.home_team_odds,
        user_predictions.home_team_predicted_win_pct,
        user_predictions.away_team,
        user_predictions.away_team_odds,
        user_predictions.away_team_predicted_win_pct,
        user_predictions.selected_winner,
        user_predictions.bet_amount,
        user_predictions.created_at,
        CASE
            WHEN home_wins.outcome = 'W'::text THEN user_predictions.home_team
            WHEN home_wins.outcome = 'L'::text THEN user_predictions.away_team
            ELSE 'TBD'::text
        END AS actual_winner
    FROM nba_prod.user_predictions
    LEFT JOIN home_wins USING (home_team, game_date)
    )
SELECT 
    combo.id,
    combo.username,
    combo.game_date,
    combo.home_team,
    combo.home_team_odds,
    combo.home_team_predicted_win_pct,
    combo.away_team,
    combo.away_team_odds,
    combo.away_team_predicted_win_pct,
    combo.selected_winner,
    combo.bet_amount,
    combo.created_at,
    combo.actual_winner,
    CASE
        WHEN combo.selected_winner = combo.actual_winner THEN 1
        ELSE 0
    END AS is_correct_prediction
FROM combo;