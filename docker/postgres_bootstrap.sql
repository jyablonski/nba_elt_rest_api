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

DROP TABLE IF EXISTS player_stats;
CREATE TABLE player_stats(
    player text,
    season_type text,
    team text,
    full_team text,
    avg_ppg numeric,
    avg_ts_percent numeric,
    avg_mvp_score numeric,
    avg_plus_minus numeric,
    games_played bigint,
    ppg_rank bigint,
    scoring_category text,
    mvp_score numeric,
    games_missed bigint,
    penalized_games_missed numeric,
    is_mvp_candidate text,
    mvp_rank bigint
);

INSERT INTO player_stats (player, season_type, team, full_team, avg_ppg, avg_ts_percent, avg_mvp_score, avg_plus_minus, games_played,
                          ppg_rank, scoring_category, games_missed, penalized_games_missed, is_mvp_candidate, mvp_rank)
VALUES ('Nikola Jokic', 'Regular Season', 'DEN', 'Denver Nuggets', 24.8, 0.702, 68, 9.5, 68, 23, 'Other', 11, 0, 'Top 5 MVP Candidate', 1),
       ('Shai Gilgeous-Alexander', 'Regular Season', 'OKC', 'Okalahoma City Thunder', 31.5, 0.628, 67, 4.1, 68, 4, 'Top 20 Scorers', 13, 0,
        'Top 5 MVP Candidate', 5);

DROP TABLE IF EXISTS team_ratings;
CREATE TABLE team_ratings(
    team text,
    team_acronym text,
    wins integer,
    losses integer,
    ortg numeric,
    drtg numeric,
    nrtg numeric,
    team_logo text,
    nrtg_rank text,
    drtg_rank text,
    ortg_rank text
);

INSERT INTO team_ratings (team, team_acronym, wins, losses, ortg, drtg, nrtg, team_logo, nrtg_rank, drtg_rank, ortg_rank)
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
        0, 0, 1, 0),
       (current_date, 'babbabooie', 'nba dos dude', null, 3232,
        'https://www.reddit.com/r/nba/',
        0, 0, 1, 0),
       (current_date, 'babbabooie_v2', 'nba dos v2 dude', null, 1111,
        'https://www.reddit.com/r/nba/',
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
    season_type text,
    n bigint,
    explanation text
);

INSERT INTO game_types (game_type, season_type, n, explanation)
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
    game_date date,
    day_name text,
    avg_team_rank bigint,
    start_time text,
    home_team text,
    away_team text,
    home_moneyline_raw numeric,
    away_moneyline_raw numeric
);

INSERT INTO schedule (game_date, day_name, avg_team_rank, start_time, home_team, away_team, home_moneyline_raw, away_moneyline_raw)
VALUES (current_date, 'Monday', 16, '7:00 PM', 'Indiana Pacers', 'New York Knicks', 300, -365),
       (current_date, 'Monday', 20, '7:00 PM', 'New York Knicks', 'Indiana Pacers', -365, 300);

DROP TABLE IF EXISTS nba_predictions;
CREATE TABLE nba_predictions(
    game_date date,
    home_team text,
    home_team_odds double precision,
    home_team_predicted_win_pct numeric,
    away_team text,
    away_team_odds double precision,
    away_team_predicted_win_pct numeric
);

INSERT INTO nba_predictions (game_date, home_team, home_team_odds, home_team_predicted_win_pct, away_team, away_team_odds, away_team_predicted_win_pct)
VALUES (date(current_timestamp - interval '5 hour'), 'Indiana Pacers', '+200', 0.247, 'San Antonio Spurs', '-160', 0.753),
       (date(current_timestamp - interval '5 hour'), 'Houston Rockets', '-140', 0.194, 'Memphis Grizzlies', '+180', 0.806),
       (date(current_timestamp - interval '5 hour'), 'Golden State Warriors', '-150', 0.712, 'Boston Celtics', '180', 0.288),
       (date(current_timestamp - interval '5 hour'), 'Dallas Mavericks', '-140', 0.194, 'Detroit Pistons', '+180', 0.806),
       (date(current_timestamp - interval '5 hour'), 'Chicago Bulls', '+200', 0.355, 'Charlotte Hornets', '-160', 0.645),
       (date(current_timestamp - interval '5 hour'), 'Utah Jazz', '+320', 0.194, 'Phoenix Suns', '-250', 0.806),
       (date(current_timestamp - interval '5 hour'), 'Washington Wizards', '+250', 0.323, 'Philadelphia 76ers', '-320', 0.677),
       (date(current_timestamp - interval '5 hour'), 'Portland Trail Blazers', '-165', 0.194, 'Sacramento Kings', '+210', 0.806);


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

INSERT INTO user_predictions (username,game_date,home_team,home_team_odds,home_team_predicted_win_pct,away_team,away_team_odds,away_team_predicted_win_pct,selected_winner,bet_amount,created_at) VALUES
	 ('test1','2023-05-14','Boston Celtics',-265,0.552,'Philadelphia 76ers',225,0.448,'Boston Celtics',10,'2023-05-14 16:16:38.800'),
	 ('test1','2023-05-16','Denver Nuggets',-245,0.72,'Los Angeles Lakers',205,0.28,'Denver Nuggets',10,'2023-05-16 23:54:01.162'),
	 ('test1','2023-05-17','Boston Celtics',-365,0.647,'Miami Heat',300,0.353,'Boston Celtics',10,'2023-05-17 23:20:01.556'),
	 ('test1','2023-05-19','Boston Celtics',-390,0.71,'Miami Heat',320,0.29,'Boston Celtics',10,'2023-05-19 19:49:34.151'),
	 ('test1','2023-05-20','Los Angeles Lakers',-225,0.365,'Denver Nuggets',190,0.635,'Los Angeles Lakers',10,'2023-05-20 15:28:01.286'),
	 ('test1','2023-05-21','Miami Heat',135,0.34,'Boston Celtics',-155,0.66,'Boston Celtics',10,'2023-05-21 16:04:20.554'),
	 ('test1','2023-05-27','Miami Heat',120,0.339,'Boston Celtics',-140,0.661,'Boston Celtics',10,'2023-05-27 22:44:41.634'),
	 ('test1','2023-05-29','Boston Celtics',NULL,0.707,'Miami Heat',NULL,0.293,'Miami Heat',10,'2023-05-29 17:56:19.546'),
	 ('test1','2023-06-01','Denver Nuggets',-360,0.895,'Miami Heat',295,0.105,'Denver Nuggets',10,'2023-06-01 18:03:51.465'),
	 ('test1','2023-06-12','Denver Nuggets',-380,0.671,'Miami Heat',310,0.329,'Denver Nuggets',10,'2023-06-12 15:45:57.518');
INSERT INTO user_predictions (username,game_date,home_team,home_team_odds,home_team_predicted_win_pct,away_team,away_team_odds,away_team_predicted_win_pct,selected_winner,bet_amount,created_at) VALUES
	 ('test1','2023-10-24','Denver Nuggets',-200,0.163,'Los Angeles Lakers',165,0.837,'Denver Nuggets',10,'2023-10-24 17:34:57.722'),
	 ('test1','2023-10-24','Golden State Warriors',-160,0.762,'Phoenix Suns',130,0.238,'Golden State Warriors',10,'2023-10-24 17:34:57.722'),
	 ('test1','2023-10-25','Miami Heat',-425,0.776,'Detroit Pistons',330,0.224,'Miami Heat',10,'2023-10-25 13:53:55.055'),
	 ('test1','2023-10-25','Charlotte Hornets',140,0.358,'Atlanta Hawks',-170,0.642,'Atlanta Hawks',10,'2023-10-25 13:53:55.055'),
	 ('test1','2023-10-25','Orlando Magic',-175,0.598,'Houston Rockets',145,0.402,'Houston Rockets',10,'2023-10-25 13:53:55.055'),
	 ('test1','2023-10-25','Brooklyn Nets',-105,0.44,'Cleveland Cavaliers',-115,0.56,'Cleveland Cavaliers',10,'2023-10-25 13:53:55.055'),
	 ('test1','2023-10-25','Toronto Raptors',100,0.529,'Minnesota Timberwolves',-120,0.471,'Minnesota Timberwolves',10,'2023-10-25 13:53:55.055'),
	 ('test1','2023-10-25','Chicago Bulls',-110,0.589,'Oklahoma City Thunder',-110,0.411,'Oklahoma City Thunder',10,'2023-10-25 13:53:55.055'),
	 ('test1','2023-10-25','San Antonio Spurs',140,0.367,'Dallas Mavericks',-170,0.633,'San Antonio Spurs',10,'2023-10-25 13:53:55.055'),
	 ('test1','2023-10-25','Los Angeles Clippers',-417,0.74,'Portland Trail Blazers',330,0.26,'Los Angeles Clippers',10,'2023-10-25 13:53:55.055');
INSERT INTO user_predictions (username,game_date,home_team,home_team_odds,home_team_predicted_win_pct,away_team,away_team_odds,away_team_predicted_win_pct,selected_winner,bet_amount,created_at) VALUES
	 ('test1','2023-10-25','New York Knicks',140,0.425,'Boston Celtics',-170,0.575,'Boston Celtics',10,'2023-10-25 13:53:55.055'),
	 ('test1','2023-10-25','Memphis Grizzlies',-115,0.61,'New Orleans Pelicans',-105,0.39,'New Orleans Pelicans',10,'2023-10-25 13:53:55.055'),
	 ('test1','2023-10-25','Indiana Pacers',-290,0.564,'Washington Wizards',230,0.436,'Washington Wizards',10,'2023-10-25 13:53:55.055'),
	 ('test1','2023-10-25','Utah Jazz',105,0.308,'Sacramento Kings',-125,0.692,'Sacramento Kings',10,'2023-10-25 13:53:55.055'),
	 ('test1','2023-10-26','Los Angeles Lakers',-225,0.228,'Phoenix Suns',185,0.772,'Los Angeles Lakers',10,'2023-10-26 13:33:36.280'),
	 ('test1','2023-10-26','Milwaukee Bucks',-250,0.535,'Philadelphia 76ers',200,0.465,'Milwaukee Bucks',10,'2023-10-26 13:33:36.280'),
	 ('test1','2023-10-27','Chicago Bulls',-140,0.111,'Toronto Raptors',115,0.889,'Toronto Raptors',10,'2023-10-27 13:48:07.160'),
	 ('test1','2023-10-27','Memphis Grizzlies',165,0.198,'Denver Nuggets',-200,0.802,'Denver Nuggets',10,'2023-10-27 13:48:07.160'),
	 ('test1','2023-10-27','Boston Celtics',-325,0.487,'Miami Heat',250,0.513,'Boston Celtics',10,'2023-10-27 13:48:07.160'),
	 ('test1','2023-10-27','Atlanta Hawks',-125,0.531,'New York Knicks',105,0.469,'New York Knicks',10,'2023-10-27 13:48:07.160');
INSERT INTO user_predictions (username,game_date,home_team,home_team_odds,home_team_predicted_win_pct,away_team,away_team_odds,away_team_predicted_win_pct,selected_winner,bet_amount,created_at) VALUES
	 ('test1','2023-10-27','Portland Trail Blazers',115,0.332,'Orlando Magic',-140,0.668,'Orlando Magic',10,'2023-10-27 13:48:07.160'),
	 ('test1','2023-10-27','Utah Jazz',130,0.158,'Los Angeles Clippers',-152,0.842,'Los Angeles Clippers',10,'2023-10-27 13:48:07.160'),
	 ('test1','2023-10-27','Cleveland Cavaliers',-160,0.597,'Oklahoma City Thunder',130,0.403,'Oklahoma City Thunder',10,'2023-10-27 13:48:07.160'),
	 ('test1','2023-10-27','Charlotte Hornets',-170,0.876,'Detroit Pistons',140,0.124,'Detroit Pistons',10,'2023-10-27 13:48:07.160'),
	 ('test1','2023-10-27','San Antonio Spurs',-130,0.284,'Houston Rockets',110,0.716,'San Antonio Spurs',10,'2023-10-27 13:48:07.160'),
	 ('test1','2023-10-27','Dallas Mavericks',-240,0.878,'Brooklyn Nets',190,0.122,'Dallas Mavericks',10,'2023-10-27 13:48:07.160'),
	 ('test1','2023-10-27','Sacramento Kings',-160,0.779,'Golden State Warriors',130,0.221,'Golden State Warriors',10,'2023-10-27 13:48:07.160'),
	 ('test1','2023-10-28','Minnesota Timberwolves',-190,0.192,'Miami Heat',160,0.808,'Minnesota Timberwolves',10,'2023-10-28 13:17:53.282'),
	 ('test1','2023-10-28','Toronto Raptors',150,0.877,'Philadelphia 76ers',-180,0.123,'Philadelphia 76ers',10,'2023-10-28 13:17:53.282'),
	 ('test1','2023-10-28','Phoenix Suns',-250,0.463,'Utah Jazz',200,0.537,'Phoenix Suns',10,'2023-10-28 13:17:53.282');
INSERT INTO user_predictions (username,game_date,home_team,home_team_odds,home_team_predicted_win_pct,away_team,away_team_odds,away_team_predicted_win_pct,selected_winner,bet_amount,created_at) VALUES
	 ('test1','2023-10-28','Detroit Pistons',105,0.531,'Chicago Bulls',-125,0.469,'Chicago Bulls',10,'2023-10-28 13:17:53.282'),
	 ('test1','2023-10-28','New Orleans Pelicans',-170,0.742,'New York Knicks',140,0.258,'New Orleans Pelicans',10,'2023-10-28 13:17:53.282'),
	 ('test1','2023-10-28','Cleveland Cavaliers',-160,0.567,'Indiana Pacers',130,0.433,'Indiana Pacers',10,'2023-10-28 13:17:53.282'),
	 ('test1','2023-10-28','Washington Wizards',105,0.356,'Memphis Grizzlies',-125,0.644,'Memphis Grizzlies',10,'2023-10-28 13:17:53.282'),
	 ('test1','2023-10-30','Toronto Raptors',-290,0.752,'Portland Trail Blazers',230,0.248,'Toronto Raptors',10,'2023-10-30 14:27:20.762'),
	 ('test1','2023-10-30','New Orleans Pelicans',-145,0.745,'Golden State Warriors',120,0.255,'Golden State Warriors',10,'2023-10-30 14:27:20.762'),
	 ('test1','2023-10-30','Memphis Grizzlies',120,0.158,'Dallas Mavericks',-145,0.842,'Dallas Mavericks',10,'2023-10-30 14:27:20.762'),
	 ('test1','2023-10-30','Charlotte Hornets',100,0.743,'Brooklyn Nets',-120,0.257,'Brooklyn Nets',10,'2023-10-30 14:27:20.762'),
	 ('test1','2023-10-30','Oklahoma City Thunder',-240,0.448,'Detroit Pistons',190,0.552,'Detroit Pistons',10,'2023-10-30 14:27:20.762'),
	 ('test1','2023-10-30','Los Angeles Lakers',-145,0.177,'Orlando Magic',120,0.823,'Orlando Magic',10,'2023-10-30 14:27:20.762');
INSERT INTO user_predictions (username,game_date,home_team,home_team_odds,home_team_predicted_win_pct,away_team,away_team_odds,away_team_predicted_win_pct,selected_winner,bet_amount,created_at) VALUES
	 ('test1','2023-10-30','Milwaukee Bucks',-200,0.489,'Miami Heat',165,0.511,'Milwaukee Bucks',10,'2023-10-30 14:27:20.762'),
	 ('test1','2023-10-30','Washington Wizards',350,0.224,'Boston Celtics',-450,0.776,'Boston Celtics',10,'2023-10-30 14:27:20.762'),
	 ('test1','2023-10-30','Denver Nuggets',-350,0.849,'Utah Jazz',260,0.151,'Denver Nuggets',10,'2023-10-30 14:27:20.762'),
	 ('test1','2023-10-30','Atlanta Hawks',110,0.471,'Minnesota Timberwolves',-130,0.529,'Minnesota Timberwolves',10,'2023-10-30 14:27:20.762'),
	 ('test1','2023-10-30','Indiana Pacers',-170,0.883,'Chicago Bulls',140,0.117,'Chicago Bulls',10,'2023-10-30 14:27:20.762'),
	 ('test1','2023-10-31','Phoenix Suns',-300,0.78,'San Antonio Spurs',240,0.22,'Phoenix Suns',10,'2023-10-31 14:49:59.012'),
	 ('test1','2023-10-31','Cleveland Cavaliers',130,0.371,'New York Knicks',-160,0.629,'Cleveland Cavaliers',10,'2023-10-31 14:49:59.012'),
	 ('test1','2023-10-31','Los Angeles Clippers',-325,0.745,'Orlando Magic',250,0.255,'Los Angeles Clippers',10,'2023-10-31 14:49:59.012'),
	 ('test1',current_date - INTERVAL '2 DAY','Toronto Raptors',175,0.239,'Milwaukee Bucks',-210,0.761,'Milwaukee Bucks',10,current_timestamp - INTERVAL '2 DAY'),
	 ('test1',current_date - INTERVAL '2 DAY','Houston Rockets',-140,0.355,'Charlotte Hornets',115,0.645,'Charlotte Hornets',10,current_timestamp - INTERVAL '2 DAY');
INSERT INTO user_predictions (username,game_date,home_team,home_team_odds,home_team_predicted_win_pct,away_team,away_team_odds,away_team_predicted_win_pct,selected_winner,bet_amount,created_at) VALUES
	 ('test1',current_date - INTERVAL '2 DAY','Minnesota Timberwolves',125,0.254,'Denver Nuggets',-150,0.746,'Denver Nuggets',10,current_timestamp - INTERVAL '2 DAY'),
	 ('test1',current_date - INTERVAL '2 DAY','Miami Heat',-250,0.393,'Brooklyn Nets',200,0.607,'Brooklyn Nets',10,current_timestamp - INTERVAL '2 DAY'),
	 ('test1',current_date - INTERVAL '2 DAY','New York Knicks',-275,0.797,'Cleveland Cavaliers',220,0.203,'New York Knicks',10,current_timestamp - INTERVAL '2 DAY'),
	 ('test1',current_date - INTERVAL '2 DAY','Utah Jazz',-145,0.513,'Memphis Grizzlies',120,0.487,'Memphis Grizzlies',10,current_timestamp - INTERVAL '2 DAY'),
	 ('test1',current_date - INTERVAL '2 DAY','Los Angeles Lakers',-210,0.404,'Los Angeles Clippers',175,0.596,'Los Angeles Clippers',10,current_timestamp - INTERVAL '2 DAY'),
	 ('test1',current_date - INTERVAL '2 DAY','Detroit Pistons',-175,0.84,'Portland Trail Blazers',145,0.16,'Detroit Pistons',10,current_timestamp - INTERVAL '2 DAY'),
	 ('test1',current_date - INTERVAL '2 DAY','Oklahoma City Thunder',-170,0.585,'New Orleans Pelicans',140,0.415,'Oklahoma City Thunder',10,current_timestamp - INTERVAL '2 DAY'),
	 ('test1',current_date - INTERVAL '2 DAY','Golden State Warriors',-290,0.722,'Sacramento Kings',230,0.278,'Golden State Warriors',10,current_timestamp - INTERVAL '2 DAY'),
	 ('test1',current_date - INTERVAL '2 DAY','Boston Celtics',-625,0.676,'Indiana Pacers',450,0.324,'Boston Celtics',10,current_timestamp - INTERVAL '2 DAY'),
	 ('test1',current_date - INTERVAL '2 DAY','Atlanta Hawks',-325,0.681,'Washington Wizards',250,0.319,'Atlanta Hawks',10,current_timestamp - INTERVAL '2 DAY');
INSERT INTO user_predictions (username,game_date,home_team,home_team_odds,home_team_predicted_win_pct,away_team,away_team_odds,away_team_predicted_win_pct,selected_winner,bet_amount,created_at) VALUES
	 ('test1',current_date - INTERVAL '2 DAY','Dallas Mavericks',-210,0.798,'Chicago Bulls',175,0.202,'Chicago Bulls',10,current_timestamp - INTERVAL '2 DAY');

-- 2023-05-28 update: this table is made from dbt in prod.  for testing im just making a blank table to test 
-- past bets functionality.
DROP TABLE IF EXISTS mov;
CREATE TABLE IF NOT EXISTS mov
(
    team text COLLATE pg_catalog."default",
    full_team text COLLATE pg_catalog."default",
    game_id bigint,
    game_date date,
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
        mov.game_date,
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
    ),

    final as (
        select 
            *,
            case
                when away_team = selected_winner then away_team_odds
                else home_team_odds
            end as selected_winner_odds,
            case when selected_winner = actual_winner then 1
                else 0 end as is_correct_prediction
        from combo
    )

    select
        *,
        case 
            when is_correct_prediction = 1 then bet_amount / abs(selected_winner_odds / 100)
            else bet_amount * -1
        end as bet_profit
    from final;

DROP TABLE IF EXISTS incidents;
CREATE TABLE IF NOT EXISTS incidents
(
	id serial primary key,
	incident_name text,
    incident_description text,
	is_active integer,
	created_at timestamp without time zone default now(),
	modified_at timestamp without time zone default now()
);
INSERT INTO incidents(incident_name, incident_description, is_active)
VALUES ('New Transactions Down', 'New Transactions have been unavailable as of July 5, 2023', 1),
       ('NBA Dashboard Lag', 'The NBA Dashboard has been experiencing latency issues since July 1, 2023', 1);
