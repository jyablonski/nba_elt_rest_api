CREATE SCHEMA nba_prod;
SET search_path TO nba_prod;

-- boostrap script boiiiiiiiii
DROP TABLE IF EXISTS prod_standings;
CREATE TABLE prod_standings(
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

INSERT INTO prod_standings (rank, team, team_full, conference, wins, losses, games_played, win_pct, active_injuries, active_protocols, last_10)
VALUES ('1st', 'MIL', 'Milwaukee Bucks', 'Eastern', 57, 22, 79, 0.722, 3, 0, '7-3'),
       ('2nd', 'BOS', 'Boston Celtics', 'Eastern', 54, 25, 79, 0.684, 4, 0, '7-3');

DROP TABLE IF EXISTS prod_scorers;
CREATE TABLE prod_scorers(
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

INSERT INTO prod_scorers (player, team, full_team, season_avg_ppg, playoffs_avg_ppg, season_ts_percent, playoffs_ts_percent, games_played, playoffs_games_played,
                          ppg_rank, top20_scorers, player_mvp_calc_adj, games_missed, penalized_games_missed, top5_candidates, mvp_rank)
VALUES ('Nikola Jokic', 'DEN', 'Denver Nuggets', 24.8, null, 0.702, null, 68, null, 23, 'Other', 48.70, 11, 0, 'Top 5 MVP Candidate', 1),
       ('Shai Gilgeous-Alexander', 'OKC', 'Okalahoma City Thunder', 31.5, null, 0.628, null, 67, null, 4, 'Top 20 Scorers', 44.10, 13, 0,
        'Top 5 MVP Candidate', 5);

DROP TABLE IF EXISTS prod_team_ratings;
CREATE TABLE prod_team_ratings(
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

INSERT INTO prod_team_ratings (team, team_acronym, w, l, ortg, drtg, nrtg, team_logo, nrtg_rank, drtg_rank, ortg_rank)
VALUES ('Boston Celtics', 'BOS', 54, 25, 118, 111.6, 6.4, 'logos/bos.png', '1st', '3rd', '2nd'),
       ('Cleveland Cavaliers', 'CLE', 50, 30, 116.4, 110.8, 5.6, 'logos/cle.png', '2nd', '1st', '8th');

DROP TABLE IF EXISTS prod_twitter_comments;
CREATE TABLE prod_twitter_comments(
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

INSERT INTO prod_twitter_comments (created_at, scrape_ts, username, tweet, url, likes, retweets, compound, neg, neu, pos)
VALUES (current_date, current_timestamp, 'KingJames', 'Man thats SIMPLY INSANE!!!! 🤣🤣🤣🤣🤣🤣🤣🤣🤣 https://t.co/WqyIWKHs4T',
        'https://twitter.com/twitter/statuses/1640515719896141826', 205431, 12757, 0, 0, 1, 0),
       (current_date, current_timestamp, 'FOS', 'The NCAA Womens National Championships 9.9 million viewers are more than',
        'https://twitter.com/twitter/statuses/1643051889846525953', 205431, 12757, 0, 0, 1, 0);

DROP TABLE IF EXISTS prod_reddit_comments;
CREATE TABLE prod_reddit_comments(
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

INSERT INTO prod_reddit_comments (scrape_date, author, comment, flair, score, url, compound, pos, neu, neg)
VALUES (current_date, 'rattatatouille', 'Jokic putting up a dismal effort', 'Spurs', 5875, 
        'https://www.reddit.com/r/nba/comments/12c4y8y/nikola_jokic_disasterclass_against_houston_14/',
        -0.6124, 0, 0.846, 0.154),
       (current_date, 'KaiserKaiba', 'NBA scriptwriters working overtime right now', null, 2829,
        'https://www.reddit.com/r/nba/comments/12c4y8y/nikola_jokic_disasterclass_against_houston_14/',
        0, 0, 1, 0);

DROP TABLE IF EXISTS prod_injuries;
CREATE TABLE prod_injuries(
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

INSERT INTO prod_injuries (injury_pk, player, team_acronym, team, date, status, injury, description,
                           total_injuries, team_active_injuries, team_active_protocols, scrape_date)
VALUES ('09a97226ecd7b666dd516039ce752720', 'Myles Turner', 'IND', 'Indiana Pacers', 'Tues, Apr 4, 2023',
        'Day to Day', 'Ankle/Back', 'Turner is questionable for Wednesdays (Apr.5) game against New York.', 4, 4, 0, current_date),
       ('0e6fe518fdecea9c84ad54608810a528', 'Tyrese Haliburton', 'Haliburton is out for Wednesdays (Apr.5) game against New York.',
        'IND', 'Indiana Pacers', 'Tues, Apr 4, 2023', 'Out', 'Ankle', 4, 4, 0, current_date);

DROP TABLE IF EXISTS prod_game_types;
CREATE TABLE prod_game_types(
    game_type text,
    type text,
    n bigint,
    explanation text
);

INSERT INTO prod_game_types (game_type, type, n, explanation)
VALUES ('20 pt Game', 'Regular Season', 356, 'between 11 and 20 points'),
       ('Blowout Game', 'Regular Season', 154, 'more than 20 points'),
       ('10 pt Game', 'Regular Season', 351, 'between 6 and 10 points'),
       ('Clutch Game', 'Regular Season', 327, '5 points or less');

DROP TABLE IF EXISTS prod_feedback;
CREATE TABLE prod_feedback(
    id serial primary key,
    feedback character varying,
    time timestamp without time zone
);

DROP TABLE IF EXISTS prod_schedule;
CREATE TABLE prod_schedule(
    date date,
    day text,
    avg_team_rank bigint,
    start_time text,
    home_team text,
    away_team text,
    home_moneyline_raw numeric,
    away_moneyline_raw numeric
);

INSERT INTO prod_schedule (date, day, avg_team_rank, start_time, home_team, away_team, home_moneyline_raw, away_moneyline_raw)
VALUES (current_date, 'Monday', 16, '7:00 PM', 'Indiana Pacers', 'New York Knicks', 300, -365),
       (current_date, 'Monday', 20, '7:00 PM', 'New York Knicks', 'Indiana Pacers', -365, 300);

DROP TABLE IF EXISTS nba_predictions;
CREATE TABLE nba_predictions(
    proper_date text,
    home_team text,
    home_team_predicted_win_pct numeric,
    away_team text,
    away_team_predicted_win_pct numeric
);

INSERT INTO nba_predictions (proper_date, home_team, home_team_predicted_win_pct, away_team, away_team_predicted_win_pct)
VALUES (current_date, 'Indiana Pacers', 0.247, 'San Antonio Spurs', 0.753),
       (current_date, 'Houston Rockets', 0.194, 'Memphis Grizzlies', 0.806);

DROP TABLE IF EXISTS prod_transactions;
CREATE TABLE IF NOT EXISTS prod_transactions
(
    date date,
    transaction text COLLATE pg_catalog."default"
);

INSERT INTO prod_transactions(date, transaction)
VALUES (current_date, 'The Portland Trail Blazers signed Skylar Mays.'),
       (current_date, 'The Toronto Raptors fired Nick Nurse as Head Coach.');


DROP TABLE IF EXISTS rest_api_users;
CREATE TABLE IF NOT EXISTS rest_api_users
(
    id serial primary key,
    username text not null,
    email text,
    created_at timestamp default now()
);
