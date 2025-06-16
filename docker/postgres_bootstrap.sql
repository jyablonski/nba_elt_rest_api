CREATE SCHEMA marts;
SET search_path TO marts;

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

INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','thy_armageddon','Blaming the fans for medical malpractice is an interesting pivot, let’s see if it pays off.','Knicks',6476,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.128,0.136,0.704,0.161),
	 ('2024-02-01','JayJax_23','We''re the baddies?','Wizards',4358,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0),
	 ('2024-02-01','akulkarnii','Send da invoice','Timberwolves',3412,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0,0,1,0),
	 ('2024-02-01','Cheifkeef29457','He’ll finish 7th in MVP voting don’t worry','Rockets',2970,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.4404,0,0.707,0.293),
	 ('2024-02-01','Pocket_Beans','He’s saying exactly what we’ve all been saying for years but people will disagree because it’s Stephen A','Celtics',2755,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.5267,0,0.825,0.175),
	 ('2024-02-01','goingtothegreek','I fine the NBA $50k for lying on the L2M, checkmate','Timberwolves',2683,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.3818,0.136,0.606,0.258),
	 ('2024-02-01','Majiebeast','They are allowed to miss 20ish% of games and still be eligible for mvp, its more then fair.',NULL,2511,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.2449,0.128,0.793,0.079),
	 ('2024-02-01','notflashgordon1975','I am with Russillo, the rule is stupid. Curry was occupying that space and Beverly launched into that space, the idea that you need to be squared up to be in proper guarding position is ridiculous to me. Players are rewarded for terrible shots way too much today, it is infuriating.','Lakers',2457,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.8271,0.077,0.72,0.203),
	 ('2024-02-01','jjkiller26','I feel like "you dont want to lose me" is speaking on behalf of a lot of fans','Raptors',2322,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.5478,0.251,0.685,0.064),
	 ('2024-02-01','jjkiller26','Lmaoooo "it''s actually the fans fault" is truly an insane way to spin this','Raptors',1937,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.3612,0.15,0.57,0.28);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','brook_lyn_lopez','not much in terms of tribute video. we had a lot of cool jerseys during his tenure, though','Nets',1877,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.3182,0.126,0.874,0),
	 ('2024-02-01','MaleficentHawk590','Guys like Jayson Tatum are listed in front of him right now.  You give Luka that Celtics roster and it''d be wraps.','Hawks',1590,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.3612,0.106,0.894,0),
	 ('2024-02-01','syllabic','I basically clubbed his knee myself','Knicks',1510,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0),
	 ('2024-02-01','captaincumsock69','I like the 65 game minimum','USA',1483,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.3612,0.385,0.615,0),
	 ('2024-02-01','MVPiid','ngl i read this as these unnamed Sixers org people blaming Embiid for letting it get to him. Either way this isn''t something the sixers should be putting out','76ers',1450,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.4939,0,0.894,0.106),
	 ('2024-02-01','saw-sync','i’m struggling to see how this makes embiid and/or the sixers seem more competent. i know that’s what they’re going for, but man i just don’t see it','TrailBlazers',1436,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.0267,0.065,0.867,0.069),
	 ('2024-02-01','127crazie','who photoshopped Pat Bev back into a TWolves jersey here? lol','Timberwolves',1431,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',0.4215,0.237,0.763,0),
	 ('2024-02-01','Jacer4','I''m literally a Thunder homer but yeah dude idk how you could ever say that wasn''t a foul, I''d be losing my mind if that happened against us','Thunder',1429,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.296,0.091,0.747,0.162),
	 ('2024-02-01','PokerPlayingRaccoon','“We thank Kevin Durant for his many months of service”','Lakers',1404,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.3612,0.217,0.783,0),
	 ('2024-02-01','PanthalassaRo','When the person you hate the most makes a banger of an argument.','Knicks',1401,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.7351,0,0.617,0.383);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','kemar7856','The rule has to be in place and 65 games is pretty lenient imo',NULL,1297,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.6486,0.306,0.694,0),
	 ('2024-02-01','Certain-Letterhead-2','As much as ppl clown him for his “weak knees” and crap, the fact he’s able to bounce back from serious injuries time and time again is ridiculous. Terrific scorer and leading a legit title contender','Thunder',1279,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',-0.2023,0.112,0.732,0.156),
	 ('2024-02-01','Galdi-br','Learning to silence other people and focus on yourself is a hard thing to do. Get well soon.

As Sartre said “Hell is other people”','BRA',1203,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.1779,0.082,0.863,0.055),
	 ('2024-02-01','JilJungJukk','Doc Rivers got randomly boo''d at the end too lol: https://streamable.com/on5nxi','Lakers',1156,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.4215,0.219,0.781,0),
	 ('2024-02-01','Miscto3','Take that for data','Nuggets',1128,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0,0,1,0),
	 ('2024-02-01','dustinharm','Hello police? This is Deandre Ayton. Damian Lillard is tryna get in the locker room and beat me up!','Lakers',1030,'https://www.reddit.com/r/nba/comments/1afy0gl/nehm_damian_lillard_on_walking_into_the_visitors/',0,0,1,0),
	 ('2024-02-01','JohnLemonnn69','Raptors legend. That 2019 title run wouldn''t be fulfilled without him dogging Embiid and being a huge wall vs. Giannis','Bucks',993,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',-0.0083,0.106,0.786,0.108),
	 ('2024-02-01','Powerglove2000','Players should keep criticizing. Refs are a joke.','Raptors',959,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.0772,0.227,0.515,0.258),
	 ('2024-02-01','trippyEDM','I wonder if they do a tribute if he didn’t ask them not to','Braves',919,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0,0,1,0),
	 ('2024-02-01','peezy2408','Haliburton saying it’s stupid bc if he doesn’t make an all nba team he misses out on 54 million lol I’d say that’s stupid too',NULL,889,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.7096,0.086,0.646,0.268);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','ajteitel','Booker was waiting all game for that one lol','Suns',836,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.4215,0.259,0.741,0),
	 ('2024-02-01','Sim888','Doc Rivers on his way to blowing a 32-14 lead!','Bulls',827,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0,0,1,0),
	 ('2024-02-01','pmartin0079','Yeah I took "me" as in the audience watching at that moment then potentially turning the game off/switching off.','Bulls',822,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.296,0.115,0.885,0),
	 ('2024-02-01','NevermoreSEA','This shit really hurts my soul.','TrailBlazers',817,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',-0.7902,0,0.364,0.636),
	 ('2024-02-01','CIark','You got da money ',NULL,789,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0,0,1,0),
	 ('2024-02-01','flexuco','It doesnt matter. His greatness will only be recognized the moment he wins a ring playing with Exum, Hardaway and Lively. Just like any other superstar in the league would.',NULL,779,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.8698,0.303,0.667,0.03),
	 ('2024-02-01','jgatch2001','Can someone explain to me why our best FT shooter in Lillard was inbounding there


It’s not just a Doc problem because this happened multiple times under Griffin as well…','Bucks',770,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0.7549,0.193,0.807,0),
	 ('2024-02-01','eGoSiGns','Seriously. Imagine being out cuz of injuries 50 days a year and thinking you''re going to get employee of the month',NULL,769,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.1779,0,0.918,0.082),
	 ('2024-02-01','Expulsure','i think mikal''s opponents do his celebration more than he does now','Nets',764,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0,0,1,0),
	 ('2024-02-01','soft-cookie','Don''t think the Raptors win their title without trading for him. Amazing player, would have been even more lethal if his prime aligned with this era','Timberwolves',760,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.8225,0.241,0.759,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','SternballAllDay','Its an ironic tribute video. To make him feel awkward','Knicks',713,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',-0.2732,0,0.721,0.279),
	 ('2024-02-01','agentdoubleohio','Hopefully does a Cuban and says fuck it and calls them out again.','Suns',706,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.2023,0.167,0.617,0.216),
	 ('2024-02-01','halfbrit08','To be fair most GM''s couldn''t put together a team as deep as that Celtics squad.','Mavs',704,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.3182,0.141,0.859,0),
	 ('2024-02-01','Numerous-Cicada3841','Yeah. This guy is an avid NBA fan. When you hear him talk, this dude really does watch the NBA every single night. Like even a shitty game between the Wizards and Portland. He’s simply saying if you lose guys like him, you’re losing fans in general. And this is true.','Kings',672,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.5574,0.225,0.637,0.138),
	 ('2024-02-01','BayesBestFriend','Fr lmao, you have an entire medical team meant to prevent this','Raptors',669,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.6124,0.333,0.667,0),
	 ('2024-02-01','jeric13xd','That shit must be a big relief for Dame. He deserved nothing but love','Bulls',648,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',-0.7005,0.108,0.529,0.363),
	 ('2024-02-01','Imthegoat175','Mikal ain’t find that shit funny 💀','Suns',646,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',-0.1779,0.276,0.381,0.343),
	 ('2024-02-01','IanicRR','People clowning him for a degenerative condition like there’s anything the man could do. He willed us to a championship on one leg, he’s in rarified air as a guy who can absolutely just get you a ring if his team is in the vicinity.','Raptors',642,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.6597,0.122,0.878,0),
	 ('2024-02-01','FlyingScissor','Dray was fined 25k for choking Gobert.',NULL,627,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.4588,0,0.667,0.333),
	 ('2024-02-01','Common_Feedback_3986','Yeah fr people have been complaining for years about this shit, and now suddenly they''re cool with it?','Raptors',594,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.3716,0.183,0.57,0.246);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','Naweezy','More motivational speaker than coach.

Fizdale was the absolute worst.','Knicks',590,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',-0.6249,0,0.687,0.313),
	 ('2024-02-01','nibbinoo8','had me like "i swore he was a laker when he did this" lmao','Celtics',586,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',0.7978,0.393,0.607,0),
	 ('2024-02-01','mug3n','These fines are absolutely nonsensical.

So this is the NBA saying what Ant said was worse than what Darko said, because Ant got fined 40k and Darko was fined 25k.','Raptors',585,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.4767,0,0.903,0.097),
	 ('2024-02-01','poeope','Embiid with a 41 percent usage rate in January lol goddam.','Celtics',574,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.1779,0.196,0.559,0.245),
	 ('2024-02-01','imploding-submarine','Basketball is becoming mind numbing and unwatchable

Obligatory edit: as one of the first commenters pointed out, and rightfully so, I should’ve said “NBA Basketball”

FIBA forever!',NULL,573,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.3382,0,0.913,0.087),
	 ('2024-02-01','highway_vigilante','Welcome home, Dame.','TrailBlazers',561,'https://www.reddit.com/r/nba/comments/1afy0gl/nehm_damian_lillard_on_walking_into_the_visitors/',0.4588,0.6,0.4,0),
	 ('2024-02-01','kindofjustalurker','the heart he did to the crowd ..... :(','TrailBlazers',559,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',-0.4404,0,0.734,0.266),
	 ('2024-02-01','Dusty_Negatives','Masterclass by Doc down the stretch.  Left himself no timeouts and then has lilliard inbound to worst shooter on team. Nice to run into a team coached worse than us.','TrailBlazers',544,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',-0.765,0.075,0.672,0.253),
	 ('2024-02-01','brams91','Pat bev sent the refs da video',NULL,541,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',0,0,1,0),
	 ('2024-02-01','FlyLikeMcFly','Cuban fumbled so Mavs can’t get that roster for Luka',NULL,539,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','retrohan7','He was such a snake oil salesman of a coach. I remember grizzlies fan saying it but I still had hope as a knick fan at the time. He did corny motivational things like this on the regular because he didn''t have the xs and os',NULL,535,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0.8934,0.24,0.76,0),
	 ('2024-02-01','HorsefacePakusa','This actually got called correctly at the end of the UNC game last night. Dude launched himself into the defender and snapped his head back, great no call. Everyone went crazy demanding a foul, but that’s the way to call it.

You don’t get a free foul cuz you torpedoed yourself into the defender. The rule has all that “defender is responsible” bullshit, well the offensive player is responsible for making an actual basketball play.','Warriors',526,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.5859,0.211,0.64,0.149),
	 ('2024-02-01','salcedoge','AD literally gets called Day to Davis, gets called street clothes and everything but the Lakers would never play him if he was hurt.

The media would say whatever, Sixers fucked up letting him play','Lakers',517,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.9502,0,0.662,0.338),
	 ('2024-02-01','SirFigsAlot','Let''s be honest it was 100% needed to change the direction of the league. The old heads already got their bags so they''re a lost cause, but the new dudes coming in will be kept to this standard... and maybe in 5 years when the young bloods become the mega stars and the "sit out" generation retires we can get back to normal','Cavaliers',516,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.0928,0.034,0.937,0.028),
	 ('2024-02-01','127crazie','Our caps actually have *skulls* on them, Hans.','Timberwolves',516,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0),
	 ('2024-02-01','bruswazi','I would like to work 79% (65/82) of my work days and still get paid my full salary eventhough I can call out sick 21% of the time but as it stands, I have to work 100% in order to pay my bills.',NULL,513,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.25,0.041,0.871,0.088),
	 ('2024-02-01','echtav','I hope every player photoshops Bev with their jersey when they do this','Lakers',510,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',0.4404,0.209,0.791,0),
	 ('2024-02-01','Mekdjrnebs','It’s a good way for the team to poison their relationship with him…and their fans lmao',NULL,509,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.5106,0.305,0.538,0.157),
	 ('2024-02-01','revisioncloud','Yeah Denver just needs a little help to be a top team. That Nikola guy has been good for them this year.','Thunder',506,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',0.8078,0.368,0.632,0),
	 ('2024-02-01','MetroExodus2033','Implies? What do you mean implies?  This is a truth. There''s no "implying" about it. We know why some of these guys sit out. They tell us. It''s not a secret.',NULL,492,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.1179,0.083,0.847,0.069);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','teh_scarecrow','I was told this man couldn''t play basketball anymore and should medically retire.','Clippers',483,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',-0.2584,0,0.844,0.156),
	 ('2024-02-01','K1ngCrimsn',' If the "Sixers organization" didn''t clear him to play against Denver then list him out 15mins before tip-off, maybe all of this wouldn''t have happened',NULL,467,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.0557,0.087,0.834,0.079),
	 ('2024-02-01','Ramu_1798','That sky blue throwback jersey goes sooo fucking hard man','Mavs',460,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',-0.1761,0,0.842,0.158),
	 ('2024-02-01','lilb1190','"You guys need to be more like Correta" - David Fizdale','Hawks',460,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0.4201,0.237,0.763,0),
	 ('2024-02-01','Amoeba_mangrove','I agree I’d be pissed too. But if someone else plays more games than you and makes all NBA, don’t they deserve the spot/the contract just as much?','VanGrizzlies',456,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.1655,0.138,0.778,0.084),
	 ('2024-02-01','Ronshol','Fake news this anonymous organization member doesn''t know shit. Embiid playing through nagging injuries is nothing new in his career.

He played yesterday because our playoff seeding is in jeopardy and that he wants to hit 65 games for MVP. Media noise was mostly irrelevant.','76ers',449,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.4168,0.129,0.709,0.162),
	 ('2024-02-01','RookieAndTheVet','His passing completely unlocked the offense, too. I really had no idea just how valuable a post playmaker could be until the trade.','Raptors',448,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',-0.1635,0.12,0.697,0.184),
	 ('2024-02-01','ffordedor','I''m actually a part of the medical staff that cleared him','Nuggets',444,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.1027,0.135,0.865,0),
	 ('2024-02-01','Fifth_Element_Matrix','Luka Magic.


Thanks Magic.',NULL,442,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.4404,0.492,0.508,0),
	 ('2024-02-01','Daniiiiii','"Guys do not throw me a surprise party. I swear! I just want a lowkey bday this time. No cake, no dinner, no elaborate thing..."','Rockets',437,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',-0.6002,0.143,0.502,0.355);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','augustus624','Two things can be true. The Sixers medical staff fucked this up and are the most to blame.

At the same time, actual reporters and media members with influence pushing the narrative that Embiid was faking his injury and ducking was pretty ridiculous. Like it’s one thing for a random redditor to say that but for a reporter to put that out there was pretty unprofessional. Ultimately though, Embiid should’ve ignored the noise.',NULL,432,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.7535,0.115,0.685,0.2),
	 ('2024-02-01','Shingorillaz','Ryen is an NBA watching sicko so yeah if it gets bad enough that he stops watching regular people probably will too. That''s what I took away from what he said anyways.','Timberwolves',428,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.3035,0.08,0.779,0.142),
	 ('2024-02-01','MaleficentHawk590','Tatum is #5 right now in MVP voting ahead of Luka.  He is carrying Jaylen Brown, Jrue Holiday, Derrick White, Kristaps Porzingis.  /s','Hawks',427,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.4019,0.109,0.891,0),
	 ('2024-02-01','cayuts21','If someone is approaching the threshold at this point in the season they need to just let it go','Timberwolves',418,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',0,0,1,0),
	 ('2024-02-01','kirbaeus','What''s da holdup','Timberwolves',414,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0,0,1,0),
	 ('2024-02-01','BBallHunter','I''m trying to understand both sides here and have a reasonable discussion.

Like, there has always been a games played requirement, now it''s just the same standard for every voter/player which makes it more fair, more transparent.

But I guess, now that the threshold is known, the players in question feel the pressure and need to play through injuries and that is something we don''t want as well. To them, it''s a lot of money and it''s easy to say for us that they already got enough of that if we aren''t in the position to lose out on that, but that''s another topic.','Thunder',411,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',0.3166,0.108,0.805,0.088),
	 ('2024-02-01','referee-superfan','That is amazing','TrailBlazers',411,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.5859,0.655,0.345,0),
	 ('2024-02-01','Classics22','<3','TrailBlazers',407,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.4404,1,0,0),
	 ('2024-02-01','KevinSorboFan','I agree this wasn''t a great example since Curry does move a little bit into PatBev''s path... but this is a good discussion on how the rule is stupid. Even if Steph did take a direct line towards the hoop (or even further to the far side of the rim... just completely conceding the lane to PatBev), the driver would still be allowed to create this contact because Steph is turned sideways.

This type of call has got to go away. The defense should be allowed a straight line to the basket when they are moving side by side with the driver. If the driving player wants to veer into the offensive player to make it harder for them to time a block, fine... but we don''t need to reward them with FTs. If the contact is egregious, even call an offensive foul.','Bucks',406,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.9223,0.077,0.782,0.141),
	 ('2024-02-01','bewarethegap','Yeah. I mean, I get it. Those guys that are in contention to lose money because of the 65 game rule are going to be upset, but there’s always been a minimum game threshold where people are going to ask “did x player really player enough to win x award?” There’s just an explicit number assigned to it now.


If you get hurt and miss a bunch of games, it’s natural that you’re not gonna get selected over another person who was able to stay on the court.


It’s not like the guys who maybe make All-NBA because Embiid or Halliburton missed too many games are putting up 12/4, they’re hooping too. Do you value that extra bag more or do you want to be at 100% when it matters? That’s what the real question becomes.




Probably better to not have media awards tied to contract incentives, but that’s something the NBPA should be fighting against','Thunder',399,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',0.3127,0.136,0.741,0.123);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','beer_down','Always will love Mikal and Cam','Suns',399,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.6369,0.457,0.543,0),
	 ('2024-02-01','notafan1','Think they wanted Giannis to bring the ball up then run a quick action to get Lillard open for three.

Looks like they forgot that fouling was a option there.','Timberwolves',397,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0.3612,0.085,0.915,0),
	 ('2024-02-01','Pizzaplan3tman','Reminds me of when LeBron set a pick for the Heat during a pre season game his second time back as a Cavalier. Was absolutely hilarious','Cavaliers',385,'https://www.reddit.com/r/nba/comments/1afy0gl/nehm_damian_lillard_on_walking_into_the_visitors/',0.4576,0.12,0.88,0),
	 ('2024-02-01','WusijiX','Before /r/NBA gets butthurt this man went to watch the Nets on his day off earlier in the season it''s just shit talk lol','Suns',383,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',-0.2023,0.099,0.775,0.127),
	 ('2024-02-01','rabid89','KawhI, Robot.','Celtics',382,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0,0,1,0),
	 ('2024-02-01','Andrewski18','Averaging a call every 12 seconds is wild on its own.

Averaging an INCORRECT call every 12 seconds is actual insanity.','Jazz',380,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.5719,0,0.837,0.163),
	 ('2024-02-01','Changsta','It''s even worse. These guys get paid their full salary regardless of how many work days they show up. They get the chance to earn a BONUS for working 79% of their days. Cry me a river.','Suns',376,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.0085,0.144,0.714,0.143),
	 ('2024-02-01','KaleAdditional776','Crazy thing is Luka is at his 3rd lowest usage rate season of his career!','Mavs',375,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.6476,0,0.711,0.289),
	 ('2024-02-01','profilemk11','Cheatin’ ass refs',NULL,374,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.5423,0,0.364,0.636),
	 ('2024-02-01','NaLu_LuNa_FairyPiece','I swear if I ever buy a ticket to a game and the millionaire I Wana watch most sits out because he wants to chill out instead of dribble and shoot a ball.. yea 65 limit and more rules need to be done.

If 40 year old injured no knees Michael Jordan can play 82 games 37 minutes a game, these younger dudes can play.',NULL,359,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.4019,0.074,0.796,0.13);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','BBallHunter','No more Wolves or Nuggets until the playoffs. Thank God.','Thunder',354,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',0.34,0.333,0.507,0.159),
	 ('2024-02-01','RTLT512','Brad Stevens is the most underrated GM in the league. He has somehow added a ton of depth to that team without draining their future draft pick stash. Every move he has made has been awesome','Rockets',353,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.6249,0.108,0.892,0),
	 ('2024-02-01','AnyEstablishment5723','I’m not a huge Ant Edwards fan but I love the fact that he says things like “I’d never miss a game if I’m able to play because sometimes for a fan thats the only game they could make it for and they deserve to see their favorite players playing”','Rockets',351,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.968,0.362,0.614,0.024),
	 ('2024-02-01','sewsgup','> it wasnt like Kawhi Leonard who dropped 38, then inexplicably cant play the next game, even though he looked fine walking off the court

didnt Kawhi tear his meniscus?',NULL,350,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.3283,0.056,0.814,0.13),
	 ('2024-02-01','nam67','thanks for everything Big Spain.  Grizzly for life.  His number will be in the rafters with ZBo','Grizzlies',344,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.4939,0.219,0.781,0),
	 ('2024-02-01','Shmokeshbutt','Disgusting assist-merchant','Magic',341,'https://www.reddit.com/r/nba/comments/1afz9za/highlight_russell_westbrook_hits_kawhi_with_the/',-0.5267,0,0.227,0.773),
	 ('2024-02-01','KrustyKrabPizzaMan','Don’t know why they didn’t listen to him. I would’ve done no tribute so the fans could be heard louder hissing like snakes (since that’s the only way to really communicate with him)','Nets',341,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.0772,0.072,0.865,0.063),
	 ('2024-02-01','HS941317','Doc Rivers off to an amazing start coaching',NULL,341,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.5859,0.352,0.648,0),
	 ('2024-02-01','ifreddiebenson','Hey they held their opponent under 120, great job doc',NULL,337,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.6249,0.313,0.687,0),
	 ('2024-02-01','zeussays','Offensive players initiating contact and getting a foul call for them is idiotic.','Lakers',333,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.765,0,0.602,0.398);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','dustinharm','Maaaan that boy hit some big shots in that building','Lakers',327,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0,0,1,0),
	 ('2024-02-01','foye2smith','Last night made it look even worse that he didn''t have an injury designation going into Denver. Like everyone in front of a mic said he was good to go then three days later his knee is giving way/buckling while he''s moving around the court?',NULL,323,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.7212,0.194,0.747,0.059),
	 ('2024-02-01','nearcatch','[Heartbreaking: The Worst Person You Know Just Made A Great Point](https://clickhole.com/heartbreaking-the-worst-person-you-know-just-made-a-gr-1825121606/)','Bulls',322,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0,0.253,0.494,0.253),
	 ('2024-02-01','Ronin607','Yeah, Russillo is known for watching meaningless games between garbage teams and dissecting it like it''s the finals. If he wants to turn off an NBA game it''s an issue.',NULL,317,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.2023,0.136,0.78,0.084),
	 ('2024-02-01','No-Hat9044','“L''enfer, c''est les autres.”
Wemby, probably.',NULL,313,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0),
	 ('2024-02-01','that_guy_is_here','Kawhi wasn''t expecting that at all','Raptors',313,'https://www.reddit.com/r/nba/comments/1afz9za/highlight_russell_westbrook_hits_kawhi_with_the/',0,0,1,0),
	 ('2024-02-01','commandrr','he was wide open for the layup lmao that’s awesome','Suns',313,'https://www.reddit.com/r/nba/comments/1afz9za/highlight_russell_westbrook_hits_kawhi_with_the/',0.8402,0.5,0.5,0),
	 ('2024-02-01','BigNathaniel69','It’s crazy that calling out officials is a bigger offense to the NBA than choking a fellow coworker.','Spurs',313,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.7506,0,0.637,0.363),
	 ('2024-02-01','CaressMeSlowly','*Stephen A = dumb bad*

*Me = smart good*

*Therefore*,

*Stephen A opinion = opposite of my opinion* 



Thats how some basic bitches think lol',NULL,312,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.4019,0.192,0.557,0.251),
	 ('2024-02-01','CMYGQZ','He managed to piss off Marc Gasol, which is honestly something I’d never expect a coach would be able to do, but he did it.','Grizzlies',309,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0.0387,0.077,0.851,0.072);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','Urgot23','Down 3 with 5 seconds to go and having Dame inbound to Giannis with no fouls to give is certainly a choice','Knicks',302,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.0516,0.111,0.787,0.102),
	 ('2024-02-01','Donquix0teDoflaming0','Nah he spittin. 65 game limit is the best thing they’ve done in a while. You shouldn’t be awarded for missing 1/3 of the season','Raptors',301,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.6486,0.226,0.656,0.118),
	 ('2024-02-01','stadiofriuli','The way the media downplayed his 73 points game tells you everything you need to know. He just doesn''t have the narrative others have while carrying bums and actually being the most valuable player in the league if you go by the literal definition of the title. The Mavs would be a lottery team without him.','NBA',292,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.5256,0.059,0.941,0),
	 ('2024-02-01','BL_RogueExplorer','Which is still fair.',NULL,291,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.3182,0.434,0.566,0),
	 ('2024-02-01','lets_talk_basketball','As a kid you''re taught defensive slides and how to turn your body to cut someone off. I understand if I initiate the contact as a defender, but when i''m simply just sliding like Steph was and the offensive player bumps into me, how is that a foul?',NULL,286,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.2617,0.112,0.775,0.113),
	 ('2024-02-01','SurpriseDonovanMcnab','A man played basketball while injured. We''re the worst.','Pistons',274,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.6597,0.169,0.352,0.479),
	 ('2024-02-01','FultonHomes','Brothers','Suns',272,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0,0,1,0),
	 ('2024-02-01','augustus624','I doubt Embiid cares about 15 year old edgelords on Twitter/Reddit. The issue was legit reporters and talking heads with influence were also pushing the narrative that he was faking his injury and being soft for not playing. Still think Embiid should’ve ignored the noise and continued to rest but understandable that it got to him',NULL,261,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.5417,0.034,0.824,0.143),
	 ('2024-02-01','BayesBestFriend','Still insane.

You literally have a medical team whose job is to prevent players from playing if they''re injured.','Raptors',259,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.5423,0.13,0.628,0.242),
	 ('2024-02-01','taititans','What the fuck','Bulls',257,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',-0.5423,0,0.364,0.636);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','DynamixRo','Gobert won me over after Draymond''s chokehold, and now KAT did it with this.','Clippers',256,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',0.5719,0.222,0.778,0),
	 ('2024-02-01','InTheMorning_Nightss','100%.  I think if they''re tip toeing that line come end of season, then we''d have slightly better discussions and takes.  But like, if you''re absolutely not on pace at All Star Break, then let''s be realistic here.','Clippers',256,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',0.6191,0.126,0.874,0),
	 ('2024-02-01','ShaedonSharpe4Life','Pau and Marc have to be one of, if not, the best brother duo in the NBA','TrailBlazers',252,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',-0.5216,0,0.826,0.174),
	 ('2024-02-01','NevermoreSEA','They (me) said that it (winning 15 basketball games) couldn''t be done. Look at us now though.','TrailBlazers',252,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0,0,1,0),
	 ('2024-02-01','cough_landing_on_you','Doc really drew that up to Giannis where he knew Portland could foul him...and you also take away one of your best offensive rebounder.',NULL,250,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0.296,0.144,0.753,0.103),
	 ('2024-02-01','ChipsyKingFisher','Bro he’s not even bald. He showed up on ESPN with a full Afro and knicks twitter was soooo funny. People were like “THIS DUDE HAD HAIR THE WHOLE TIME!?” Lmao',NULL,250,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0.8622,0.262,0.738,0),
	 ('2024-02-01','hrakkari','It’s the Sixers fault for having a Nuggets fan on their medical team.','Nets',249,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.1027,0.153,0.667,0.18),
	 ('2024-02-01','Sullan08','I also don''t understand. The medical staff forced him to sit against the Nuggets, but couldn''t do it this game? This is not on any fans lmao. The org has to make that decision to protect a player.',NULL,245,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.8294,0.2,0.754,0.046),
	 ('2024-02-01','ogragreg04','We dont get past Philly without him','Raptors',245,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0,0,1,0),
	 ('2024-02-01','therealunbread','That’s like the Wayne Gretzky and his brother stat lmao','Bucks',244,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.7506,0.444,0.556,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','The12thman94','I just can''t get past it.   I''m having the hardest time reconciling my Blazers fandom with losing Dame ',NULL,243,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',-0.3818,0,0.86,0.14),
	 ('2024-02-01','MrBuckBuck','When you press on all your buttons in 2k.','Wizards',241,'https://www.reddit.com/r/nba/comments/1afz9za/highlight_russell_westbrook_hits_kawhi_with_the/',0,0,1,0),
	 ('2024-02-01','meowhatissodamnfunny','It''s really whack how obviously OP tries to spin the title to make Ryen look like an asshole when he''s bitching about the same stuff /r/nba bitches about ALL. THE. TIME.

Maybe his phrasing wasn''t great but I think it''s clear for anyone that listens to Ryen he wasn''t doing it from some like elitist position or something. He''s just mad his favorite sport is being turned into refball',NULL,235,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.4503,0.15,0.724,0.126),
	 ('2024-02-01','zmegadeth','> also it’s fine for refs to make mistakes

The issue is they have time to dissect it and review it from all angles during the L2M report. If they miss something in the heat of the moment, ok, but to sit back and say "nah that''s clean" is wild','Grizzlies',234,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.4404,0.121,0.793,0.086),
	 ('2024-02-01','farteagle','If you lose the guy who has no social life, wife, kids  specifically because he needs to be able to brag about how many NBA games he watched - it’s definitely a terrible sign for how normal fans are feeling',NULL,229,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.5859,0.093,0.73,0.177),
	 ('2024-02-01','TerryPressedMe','I hope we can get another epic Kawhi playoff run. It seems like he’s warming up to it.',NULL,228,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.7184,0.333,0.667,0),
	 ('2024-02-01','mehhh89','That''s what sports should be about. Having a good time and appreciating the good times.','TrailBlazers',226,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.8271,0.442,0.558,0),
	 ('2024-02-01','EmiyaShiroko','Yeah, he did. SAS hates him so he ignored that injury.','Lakers',226,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.7251,0.126,0.4,0.474),
	 ('2024-02-01','defiantcross','that''s the only way you are allowed to win a ring as a Mav.','Suns',226,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.5859,0.257,0.743,0),
	 ('2024-02-01','zwondingo','Outcoached by Chauncey Fucking Billups.  Lmao',NULL,226,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0.6344,0.455,0.545,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','bearsquadz','> Yeah. This guy is an avid NBA fan. When you hear him talk, this dude really does watch the NBA every single night.

he grinds so much tape dude you don''t even know','SRB',225,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.6908,0.183,0.817,0),
	 ('2024-02-01','tbone747','I''ll never understand folks who clown players that are unfortunate enough to have to suffer with injuries like that.','ChaHornets',225,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',-0.6124,0.1,0.64,0.26),
	 ('2024-02-01','None','[deleted]',NULL,224,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0,0,1,0),
	 ('2024-02-01','oldmastacannoli','Respect where it''s due -- Blazers played a great game, and Scoot balled out in the first quarter. Dude is light years ahead of where he started the season, and still improving.','Heat',223,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.9081,0.315,0.685,0),
	 ('2024-02-01','eeeedlef','What if those injuries are sustained by saving your entire office''s lives by taking down a violent intruder?','Timberwolves',223,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.5994,0,0.804,0.196),
	 ('2024-02-01','BowlWinHoosiers','Appreciate the guys not phoning in this game even with Jokic out. Painful loss but you can’t fault the effort of the team against a damn good Thunder squad','Nuggets',222,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',-0.6124,0.148,0.573,0.279),
	 ('2024-02-01','HardcoreKaraoke','I get why it seems silly but I''m curious how many people commenting have actually been to an NBA game (or any sport) when a long tenured or significant player returns. They almost always show quick videos like this.

It''s really not a big deal. Role players get them. It''s usually just a short ~20 second montage they play during the first TV timeout. It''s not like they have a halftime celebration, it''s not like they''re presenting them with a trophy. It''s literally just a graphic they show in the arena.

Because it''s KD I feel like a lot of people are making it out to be a big deal but it really isn''t if you''ve ever been to a game. Shit happens a lot.','Mavs',222,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.9371,0.17,0.793,0.037),
	 ('2024-02-01','lalakingmalibog','Hell nawl can''t pay dis','Mavs',221,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.649,0.146,0.337,0.517),
	 ('2024-02-01','NeedleGunMonkey','Kawhi: calibration nominal.',NULL,221,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0,0,1,0),
	 ('2024-02-01','PlayInChampions','Not losing my mind because we won, also it’s fine for refs to make mistakes. Not the worst officiated game I’ve seen, at least KAT got some free throws, we don’t see this shit often. Refs missed two egregious fouls against Ant (Chet’s fake block and Shai’s foul at the end), everything else was fine. I think the most frustrated part for Ant was Shai getting every call while he did not.','Timberwolves',220,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.5522,0.172,0.63,0.199);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','Angelic_Phoenix','aww look how corrupt tho','Celtics',219,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0,0,1,0),
	 ('2024-02-01','ModernaPfizerJr','The Mavs need either a 70 pt game or a 40 pt triple double to win against teams like the Hawks. Just think about that for sec about how badly Cuban has fucked up.','West',219,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.296,0.151,0.67,0.179),
	 ('2024-02-01','Tom_Brady_Cheats','r/nba made Kuminga fall on his knee. Makes perfect sense.','Bulls',218,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.5719,0.291,0.709,0),
	 ('2024-02-01','bewarethegap','“Let’s blame the fans for him getting injured. They clearly make the decisions.”','Thunder',218,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.34,0.152,0.562,0.287),
	 ('2024-02-01','LocalPharmacist','For those who aren’t casuals, you’d know Sochan was our most promising player last season, and now that’s he’s at his natural position, he’s continuing to show that.','Spurs',216,'https://www.reddit.com/r/nba/comments/1afym20/highlight_jeremy_sochan_pulls_out_the_reverse/',0.6697,0.174,0.826,0),
	 ('2024-02-01','fuunii','[Jose Calderon walking to wrong locker room :20](https://www.youtube.com/watch?v=3WuDCWelR9g)',NULL,214,'https://www.reddit.com/r/nba/comments/1afy0gl/nehm_damian_lillard_on_walking_into_the_visitors/',-0.4767,0,0.693,0.307),
	 ('2024-02-01','Musa_2050','Deep down, Durant loved it. He likes being praised but at times is humble about it','Lakers',213,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.6652,0.332,0.668,0),
	 ('2024-02-01','OKC2023champs','Not sure why he inbounded that lol','Thunder',213,'https://www.reddit.com/r/nba/comments/1ag3pwx/damian_lillard_loses_in_his_return_to_portland/',0.2115,0.287,0.512,0.201),
	 ('2024-02-01','Drummallumin','KD got all-nba votes last season and played 47 games. The reason this rule exists is cuz the voters sucked.','Celtics',212,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',-0.1531,0.103,0.769,0.128),
	 ('2024-02-01','yic0','Devin Booker is Mikal Bridges’ brother.','TrailBlazers',208,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','CaressMeSlowly','i used to be an MVP like you, until i took a club to the knee',NULL,206,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.3612,0.172,0.828,0),
	 ('2024-02-01','ddy_stop_plz','Our roster in 2021 was so bad it’s a miracle we rebounded. Kemba with one knee, Tristan Thompson, Semi Ojeleye, Jabari Parker, Fournier, Carsen Edwards, Tacko Fall, and Romeo Langford all played minutes for us.',NULL,205,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.2435,0.154,0.739,0.107),
	 ('2024-02-01','spiderpigface','Down one and got two stops, just couldn''t get the board. Tough break but good fight at the end','Nuggets',202,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',-0.0258,0.155,0.605,0.24),
	 ('2024-02-01','RoyalConclusion9','Sub absolutely ate that up',NULL,201,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0,0,1,0),
	 ('2024-02-01','CMYGQZ','This all started because Sixers themselves fucked up. It was them was cleared Embiid to play the Denver game, so when he randomly got “injured” 15 minutes before the games, of course journalists (or just humans with a brain) would question why he wasn’t on the report at all. Had he been like questionable game time decision, none of this would’ve happened, but no he was fully available.','Grizzlies',200,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.5346,0.064,0.838,0.098),
	 ('2024-02-01','xerxesthagreat','took that snub personal',NULL,199,'https://www.reddit.com/r/nba/comments/1afym20/highlight_jeremy_sochan_pulls_out_the_reverse/',-0.4215,0,0.517,0.483),
	 ('2024-02-01','TinnieTa21','I actually thought that 65 games was a little too generous. 70 seemed fair to me. 20% of a season just seems like a lot.','Raptors',197,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.7796,0.303,0.697,0),
	 ('2024-02-01','TheSunsNotYellow','The thing is, I see no-calls in these situations, but usually only in the final few minutes of games or high pressure atmospheres. Almost as if officials know when to get “tricked” and when not to','Thunder',196,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.4215,0,0.924,0.076),
	 ('2024-02-01','PapaJisinmyhouse','Luka is due. I believe he had as good an argument as any for MVP the past few years. Would be nice to see him get one. I know the team success is not quite there, but he wouldn’t be the first guy to win with a lower seeded team.','76ers',196,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.7814,0.2,0.72,0.08),
	 ('2024-02-01','flexuco','Does he ever play? Besides, Kyrie and Luka with this roster can''t win shit anyway.',NULL,194,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.3076,0.261,0.588,0.151);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','512fm','The nba is, it’s a completely seperate product to other basketball','Pistons',192,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0,0,1,0),
	 ('2024-02-01','RookieAndTheVet','He’ll never have to buy a beer (or wine, in his case) in Toronto, either.','Raptors',189,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0,0,1,0),
	 ('2024-02-01','Carcrusher3','The world got to see Scoot, Toumani, Duop in primetime and the rooks showed out.

Love you Dame, Doc sucks why the fuck you don''t get Dame multiple looks there.','TrailBlazers',189,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',-0.2023,0.113,0.726,0.161),
	 ('2024-02-01','pollinium','Portland knows ball','Timberwolves',188,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0,0,1,0),
	 ('2024-02-01','SuckMyLonzoBalls','stephen ass smith','Clippers',188,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',-0.5423,0,0.364,0.636),
	 ('2024-02-01','beklog','or if they didnt clear him to play against GSW if he''s really hurt.','Celtics',186,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.5388,0.125,0.571,0.305),
	 ('2024-02-01','LoWE11053211','i bet he waited way more than one game','Clippers',186,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0,0,1,0),
	 ('2024-02-01','-Schweini31-','Mini 🤏','Suns',186,'https://www.reddit.com/r/nba/comments/1ag192x/kd_with_some_friendly_trash_talk_to_his_friend/',0,0,1,0),
	 ('2024-02-01','defiantcross','i saw him do some kind of monocle thing earlier in the game after a 3.  is that his thing now?','Suns',184,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0,0,1,0),
	 ('2024-02-01','ChipsyKingFisher','The NBA is, despite being the highest level, completely different than all other basketball. We all were taught rules. The NBA has the same ones, they just don’t follow them.

Try playing like an NBA player in a pickup game. Carry and travel ever play, set a ridiculous moving screen every time you set a pick. Throw yourself into your defender when you have the ball and flail.

In the NBA that’s the way the game works, on any basketball court anywhere else you’d piss everybody off and nobody would want to play with you.',NULL,182,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.5574,0.117,0.832,0.051);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','ItsN0tTheB0at','maybe they can fire Adrian Griffin again','Celtics',181,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',-0.34,0,0.714,0.286),
	 ('2024-02-01','qpwoeor1235','That moment needs to be enshrined in the nba hall of fame. Surreal when it happened',NULL,181,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',0.4404,0.162,0.838,0),
	 ('2024-02-01','euph31','I think he was holding in a laugh or he''ll laugh about it later.','Suns',180,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.802,0.419,0.581,0),
	 ('2024-02-01','canseco-fart-box','And even those medical teams have medical teams. There’s a lot of layers to this failure here and fans are probably the least of the issue','Knicks',179,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.596,0,0.861,0.139),
	 ('2024-02-01','ShaedonSharpe4Life','I wish more than anything he plays a year and retires with us','TrailBlazers',178,'https://www.reddit.com/r/nba/comments/1afy0gl/nehm_damian_lillard_on_walking_into_the_visitors/',0.5719,0.343,0.657,0),
	 ('2024-02-01','Koufaxisking','Sixers FO has a sterling reputation for their communication practices so clearly this is an Embiid issue. I''ve never heard of Sixers top brass trash talking its star players ever before.','Lakers',176,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.6476,0.159,0.841,0),
	 ('2024-02-01','litthefilter','“Le paradis, c''est les épouses des autres” Tony Parker, probably','Nuggets',176,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0),
	 ('2024-02-01','Wembantonio','Sochan is making a leap this season. He''s been so good since moving back to his position.','Spurs',175,'https://www.reddit.com/r/nba/comments/1afym20/highlight_jeremy_sochan_pulls_out_the_reverse/',0.5777,0.2,0.8,0),
	 ('2024-02-01','Kashmir33','Because LeBron won two championships and made four finals with Fizdale as an assistant. You seriously don''t know why that would cloud his judgement?','NBA',174,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0.7351,0.233,0.709,0.057),
	 ('2024-02-01','floatermuse','Kind of crazy because I normally associate ball dominant guards like Luka and Harden with that level of usage

Don’t think I’ve ever seen that type of stuff from a center before ',NULL,173,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.0258,0.076,0.851,0.073);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','cuttino_mowgli','Meme of the decade if Milwaukee drops to 10th place after firing Adrian Griffin lmao','Thunder',171,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.3612,0.202,0.674,0.124),
	 ('2024-02-01','MAMBAMENTALITY8-24','Love how you have to explain this, the haters will arrive soon','Thunder',171,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.25,0.241,0.575,0.184),
	 ('2024-02-01','Scottsid','>Masterclass by Doc down the stretch.  Left himself no timeouts and then has lilliard inbound to worst shooter on team. Nice to run into a team coached worse than us.

Doc is a proven idiot. How you win one chip'' with recently arrested Rondo, Ray Allen, Paul Pierce, and Kevin Garnet is a head scratcher. Blew so many playoff leads with favored rosters. Budenholzer is building his resume for his next job by the day....All he has to say is look at these bozos without me.',NULL,171,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',-0.7506,0.094,0.749,0.158),
	 ('2024-02-01','Several_Nature_9593','Doctor Rivers would blame Tobias Harris.',NULL,170,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.34,0,0.676,0.324),
	 ('2024-02-01','Colorado_designer','I guarantee he wouldn’t be getting this level of scrutiny if he didn’t campaign for MVP all last year including that “interview” at the end throwing shade at Jokic. Also, playing through it clearly shows the MVP IS more important to him than being healthy for the playoffs.','Nuggets',170,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.8516,0.212,0.788,0),
	 ('2024-02-01','Long_Chance3583','I was just listening to the newest Lowe Post and Chiney Ogwumike was talking about how frustrating the current rules are for defenders. She said that as a defender you cannot defend yourself from an offensive player launching in to you.

This is a sentiment I feel all the time, and as she was taking the words directly out of my soul, it suddenly hit me that people who don’t feel this way must simply not care about playing defense. I mean actually give a shit about playing defense.

This is the only logical answer to me. One, because as a coach, I know that many players don’t actually take pride in defense. And two, because I fail to see how anyone whom does take pride in defense sees the current landscape of basketball and thinks it’s okay.

Just yesterday I saw a player bowling ball backwards and take out my centers legs while screaming and 1 and putting up a horrible shot that had no chance. This isn’t just stupid, it’s dangerous. A modern defensive player is tasked with staying near the ball handler, but if the ball handler suddenly decides to bowling ball into your body, you are now called for a foul.

It is an oxymoron that should break the brain of basketball fans. But the reality is most fans only see the offensive side of the ball. While many players only care about their box score, and their highlights, which rarely show defense.

And then our best American players go overseas, on star studded rosters, and get embarrassed on a global stage as they flail for fouls and endlessly travel into turnovers.','Heat',169,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.9287,0.082,0.796,0.122),
	 ('2024-02-01','MerkDoctor','Ant Edwards and Tatum both the future faces of the league and both saying the same good shit, gotta love it.',NULL,168,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.5423,0.247,0.627,0.125),
	 ('2024-02-01','jgatch2001','If the Bucks wanna pitch it back, why not inbound to Lopez or one of the other players who can actually hit free throws? Just bad play design','Bucks',168,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0.296,0.167,0.731,0.102),
	 ('2024-02-01','Dogdaypm89','Playing 8 on 5 out there','Suns',168,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',0.2023,0.375,0.625,0),
	 ('2024-02-01','Substantial-Fold-592','In his prime, Foster would have called this a technical and ejection for Booker. Father time has claimed another victim','Suns',167,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',-0.2732,0,0.896,0.104);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','DomDomRevolution','Im going to say it’s probably less about the fans and more about the NBA media  ','76ers',166,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0),
	 ('2024-02-01','NudeEnjoyer','not much in terms of a Kevin Durant look either. that''s just kinda Kevin''s face lmao','Nets',165,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.5627,0.206,0.794,0),
	 ('2024-02-01','Sunnyinphx01','Mikal can''t win with these cats',NULL,164,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',-0.4717,0,0.619,0.381),
	 ('2024-02-01','creepypaster','i remember our first game with philly the year after too.  Held joel to 0-11 and 0 pts,4 TOs. Absolutely sonned the man, joel looked like he didn''t even want to be on the court lmao','Raptors',164,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.7334,0.166,0.803,0.032),
	 ('2024-02-01','TheRealPdGaming','new orleans sat him so he wouldn''t get hurt. davis wanted to continue to play','Mavs',163,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.6341,0.285,0.715,0),
	 ('2024-02-01','swhos','"Leader of men" type','Clippers',162,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0,0,1,0),
	 ('2024-02-01','Drunken_Vike','straight cash homie','Timberwolves',161,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.2263,0.487,0.513,0),
	 ('2024-02-01','SpicyP43905','NBA refs don’t get nearly enough hate.','Raptors',161,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.5719,0,0.619,0.381),
	 ('2024-02-01','meandmywoes','If you can’t be assed to be on the court you don’t deserve a super max deal',NULL,161,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.5994,0.206,0.794,0),
	 ('2024-02-01','Eaglewarrior33','He gave his heart and soul to that city.','Warriors',160,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','Ayjel89','Anthony Edwards: I''m gonna take the fine

NBA: Fuck yeah you will',NULL,160,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.128,0.242,0.545,0.212),
	 ('2024-02-01','DiCaprio_Too','It''s because they don''t understand the injury itself. Unless things are broken outright, torn, snapped or you''re seen in a cast, the injury just magically doesn''t exist','Thunder',160,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',-0.1119,0.147,0.693,0.161),
	 ('2024-02-01','DrZoidberg117','https://youtu.be/eyjTFE9DMQs?si=-kmVLKhXpjAtjEkp',NULL,160,'https://www.reddit.com/r/nba/comments/1afy0gl/nehm_damian_lillard_on_walking_into_the_visitors/',0,0,1,0),
	 ('2024-02-01','spiiicychips','Don''t think it''s going to happen but would love for a team to just forfeit once you get a game with just egregious calling.  Darko, would be my guess 👀👀👀','Warriors',159,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.7783,0.177,0.823,0),
	 ('2024-02-01','sirthatsnotanumber','Welcome to the Doc experience Bucks fans','76ers',158,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.4588,0.333,0.667,0),
	 ('2024-02-01','Darktider','Durant pointing and laughing too. Damn lol','Suns',158,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.5106,0.472,0.315,0.213),
	 ('2024-02-01','markymags','This is how I picture Darvin Ham this season especially after all the comments by players saying they don''t know what defense they are supposed to be in.','Lakers',156,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',-0.0951,0,0.95,0.05),
	 ('2024-02-01','LeBremsstrahlung','One of the best trade deadline acquisitions ever.','Mavs',156,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.6369,0.375,0.625,0),
	 ('2024-02-01','mr_showboat','Always have been','Celtics',156,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0),
	 ('2024-02-01','Crimith','That''s Rudy''s whole gig in a nutshell','Jazz',156,'https://www.reddit.com/r/nba/comments/1afzqhm/highlight_rudy_gobert_makes_it_difficult_for/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','jademadegreensuede','Nuggets spo0ky, might make a splash in the playoffs this year. Don’t worry Nuggets, maybe you’ll be a great team in 5 years :)

(That hurt to type and I’m sorry)','Timberwolves',156,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',0.2023,0.19,0.642,0.168),
	 ('2024-02-01','Ihate_reddit_app','It reminds me of a play earlier in the year when KAT drove and a defender cut into him causing both to lose balance and he fell into a different defender blocking. It was called a charge on KAT and the Wolves challenged it. The refs came back and said the defender that cut between them was only "marginal contact", therefore it was still a charge.

[Here it was. This was called a foul on KAT and confirmed on challenge.](https://streamable.com/dqgwez)',NULL,156,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.6486,0.08,0.788,0.132),
	 ('2024-02-01','CumAssault','Luka scored 73 a few nights ago and tonight the Mavs can only break 80 points','Spurs',156,'https://www.reddit.com/r/nba/comments/1ag2hl8/highlight_target_center_goes_crazy_for_free/',0,0,1,0),
	 ('2024-02-01','Aestro17','The same reason he passed to Brook Lopez with 5.6 seconds left. He still loves Portland.','TrailBlazers',155,'https://www.reddit.com/r/nba/comments/1ag3pwx/damian_lillard_loses_in_his_return_to_portland/',0.5719,0.198,0.802,0),
	 ('2024-02-01','Avant-Garde-A-Clue','MJ really doesn’t get the credit for this he deserves. People make jokes about Wizards Jordan but the man played all 82 games at 37mpg and averaged 20ppg at 40 years old.

That is one “achievement” that will never be duplicated.','NBA',154,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.6597,0.144,0.856,0),
	 ('2024-02-01','Smekledorf1996','People mix up usage rate and time of possessions with each other tbf

Like CP3 was very ball dominant for years, but his usage rate % fluctuated between low to mid 20s',NULL,154,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.2263,0.052,0.868,0.079),
	 ('2024-02-01','this_good_boy','Wolves game against the hornets.',NULL,153,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0,0,1,0),
	 ('2024-02-01','Even_Note_1604','im glad it''s all love even tho things got a little ugly trade wise',NULL,153,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.7923,0.455,0.408,0.136),
	 ('2024-02-01','No-Animator-6348','Hell naw can’t do dis',NULL,152,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.6808,0,0.465,0.535),
	 ('2024-02-01','JohnnyDepputy','He was their best player for 3 years and it was a huge deal when they signed him. Not acknowledging that at all seems weird. Also it’s like a 20-second video, who cares.',NULL,152,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.8834,0.31,0.646,0.044);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','Sosuayaman','Calling the integrity of the league into question is a big deal when gambling is a major revenue stream. ',NULL,152,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.3818,0.14,0.86,0),
	 ('2024-02-01','ChannelNeo','Elfrid Payton is the Magic all time leader in triple doubles

I remember when he and Oladipo would be the future','Magic',151,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0,0,1,0),
	 ('2024-02-01','Sim888','[can’t blow a 3-1 lead if you don’t make the playoffs!](https://i.imgur.com/oBkxizF.gifv)','Bulls',150,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0,0,1,0),
	 ('2024-02-01','poeope','They inbounded to Giannis down 3 lmao','Celtics',150,'https://www.reddit.com/r/nba/comments/1ag3pwx/damian_lillard_loses_in_his_return_to_portland/',0.5994,0.438,0.562,0),
	 ('2024-02-01','RealKevinGarnett','What? So a grown ass man saw some nobodies on the internet talking shit and decided he would jeopardize his health and team success to prove them wrong? That’s on him.','Timberwolves',149,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.7986,0.091,0.641,0.267),
	 ('2024-02-01','tica_spi','I dunno dude, being a blazers fan has been pretty consistently heartbreaking','TrailBlazers',149,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.3612,0.355,0.452,0.194),
	 ('2024-02-01','aslightlyusedtissue','Nothing on my MyPlayers’ 78% usage rate on his way to an MVP ROTY and FMVP','Lakers',148,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0,0,1,0),
	 ('2024-02-01','DadOfWhiteJesus','All my heroes are cornballs 😢','Nuggets',147,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.5106,0.452,0.548,0),
	 ('2024-02-01','alpacamegafan','Honestly, I thought that he did the same thing on the Wolves for a second, which is even funnier to think about.','Pelicans',147,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',0.6908,0.241,0.759,0),
	 ('2024-02-01','c_c_c__combobreaker','"Those 43 games you''ve played for us over 3 seasons were something us fans will never forget"','Lakers',146,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.4707,0.225,0.775,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','Salty_Watermelon','Perhaps Russ is becoming self aware that he doesn''t have the softest touch on his layups.  Great play either way.','Clippers',146,'https://www.reddit.com/r/nba/comments/1afz9za/highlight_russell_westbrook_hits_kawhi_with_the/',0.7579,0.265,0.735,0),
	 ('2024-02-01','Dragonsandman','Him being absolutely shitfaced during the parade was legendary, especially when he was trying his hardest to hold it together while sitting next to Trudeau','Raptors',146,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0,0,1,0),
	 ('2024-02-01','Rswany','That''s my DPOY','Timberwolves',146,'https://www.reddit.com/r/nba/comments/1afzqhm/highlight_rudy_gobert_makes_it_difficult_for/',0,0,1,0),
	 ('2024-02-01','ImChz','Yeah, idk what happened to player control fouls. Most frustrating shit ever is seeing an offensive player running through the lane like a bull in a China shop, pummel a defender, and somehow they end up shooting FTs. It doesn’t make sense.','ChaHornets',146,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.7485,0.123,0.646,0.231),
	 ('2024-02-01','Downtown_Soft_202','Did Doc Rivers really have Lillard inbound the ball to Giannis down 3??',NULL,145,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0,0,1,0),
	 ('2024-02-01','Nookoh1','oh. i have the ball know. guess that goes in the hoop','Bucks',145,'https://www.reddit.com/r/nba/comments/1afz9za/highlight_russell_westbrook_hits_kawhi_with_the/',0,0,1,0),
	 ('2024-02-01','No_Progress_278','Very classy Portland fans. Ngl that was pretty cool of y’all',NULL,144,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.8268,0.521,0.479,0),
	 ('2024-02-01','LegendOfSoccer','Luka should be top 3 in MVP list. I don’t understand how he is 7th','Mavs',144,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.2023,0.13,0.87,0),
	 ('2024-02-01','MattAU05','I don''t know man, anyone saying that Kevin Durant was intentionally not playing basketball when he could otherwise be playing basketball is a little crazy. I don''t think anyone likes basketball more than KD.','Suns',143,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.6831,0,0.78,0.22),
	 ('2024-02-01','Several_Nature_9593','Steph and Seth have 4 rings to their 3 rings.

Both brothers have a combined 9 all star appearances.',NULL,143,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','KillerMemestarX','People saying that all Masai did was the Kawhi trade is the easiest casual detector of all time, because without the Gasol trade we wouldn’t have even gotten to the finals.','Raptors',143,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.5574,0.137,0.863,0),
	 ('2024-02-01','yic0','A hero''s welcome!','TrailBlazers',143,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.5093,0.767,0.233,0),
	 ('2024-02-01','PestyAssassin33WU93','Chet is clutch as fuck. Hasn''t he hit like 2 game winners already this season?','ChaHornets',143,'https://www.reddit.com/r/nba/comments/1ag14vv/highlight_holmgren_hits_daggers_triple_with_vs/',-0.3632,0.157,0.558,0.285),
	 ('2024-02-01','ThingsAreAfoot','A few years ago he woulda yammed that shit off the spin','Wizards',141,'https://www.reddit.com/r/nba/comments/1afz9za/highlight_russell_westbrook_hits_kawhi_with_the/',-0.5574,0,0.735,0.265),
	 ('2024-02-01','lakers082433','I hope bro wins another ring. I love this dude','Lakers',141,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.8957,0.684,0.316,0),
	 ('2024-02-01','xzadetechnoHD','Please give micic all of the minutes I love this man','Thunder',139,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',0.7579,0.448,0.552,0),
	 ('2024-02-01','UnhingedSupernova','Imagine if they miss the playoffs after this game.','USA',138,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',-0.1531,0,0.833,0.167),
	 ('2024-02-01','Disastrous_Bluejay57','PPB* WAS CALLED!

*Is PPB the Portland equivalent of the LAPD?','Nuggets',138,'https://www.reddit.com/r/nba/comments/1afy0gl/nehm_damian_lillard_on_walking_into_the_visitors/',0,0,1,0),
	 ('2024-02-01','Padulsky21','My favorite is Cam’s response about it

[“KD just be trolling… I’m sure they’ll give him one. He did a lot here… He just be trolling. Don’t listen to Kevin.”](https://x.com/erikslater_/status/1752175080526758183?s=46&t=tQCyDe91F9UpAGqh-_n_yA)','Nets',138,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.6486,0.164,0.836,0),
	 ('2024-02-01','Similar_Reach_7288','It''s not completely unrelated. Who do you think those talking heads in the media pander to the most?',NULL,137,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','wishwashy','The gf that leaked it must hate that this is what we all took away from it. A bunch of memes and jokes lol',NULL,137,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.296,0.161,0.638,0.201),
	 ('2024-02-01','Mekdjrnebs','The Lakers put an injury designation on LeBron practically every other game. I don’t get why the Sixers don’t follow a similar strategy for their injury reports.',NULL,135,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.6808,0,0.804,0.196),
	 ('2024-02-01','VitorSiq','Inbounding to the worst FT shooter on the team no less','Pacers',133,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',-0.743,0,0.588,0.412),
	 ('2024-02-01','Drag0nborn1234','He''s managed to get Player of the week once this season so far....yeah','Mavs',132,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0,0,1,0),
	 ('2024-02-01','Fafoah','This kind of rah rah stuff is fine, but you gotta have the basics done first

Pop makes his players go to museums and shit and phil jackson is a straight up hippie ￼but it works because aside from that they were good at the regular stuff','Bulls',132,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0.1779,0.139,0.771,0.09),
	 ('2024-02-01','Numerous-Cicada3841','It’s funny because this demonstrates voters *clearly* think games played matters when it comes to MVP. But then when it comes to things like All-NBA it shouldn’t? If it’s good for the goose it’s good for the gander.','Kings',132,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',0.928,0.328,0.672,0),
	 ('2024-02-01','Wazflame','Yeah, he was actually cooking on this segment lol, he did his research',NULL,131,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.6124,0.312,0.688,0),
	 ('2024-02-01','twotonkatrucks','Trying to do his best Pop impression.','Spurs',130,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0.7269,0.55,0.45,0),
	 ('2024-02-01','Conn3er','He obviously missed the 2nd on purpose

Hopefully at least','Spurs',130,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0.128,0.209,0.62,0.171),
	 ('2024-02-01','pjtheMillwrong','It’s for All NBA as well','Raptors',130,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.2732,0.296,0.704,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','recollectionsmayvary','I’m honestly hoping they did the tribute video bc they knew he asked them to not do it lol the mind games of that would be funnier.','Nets',129,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.7326,0.251,0.68,0.069),
	 ('2024-02-01','mrsunshine1','Bro would go to a party and walk out once he realized no one was watching Hornets @ Pistons.','Knicks',129,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.128,0.136,0.754,0.111),
	 ('2024-02-01','ftghb','hey, here''s a crazy idea: just call it consistently in both circumstances. It honestly hurts the game when they selectively enforce it','Warriors',129,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.3612,0.113,0.679,0.208),
	 ('2024-02-01','Shmokeshbutt','The Nets organization has zero self-respect

It''s like a chick with daddy issue','Magic',129,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.3612,0.185,0.815,0),
	 ('2024-02-01','nate517','Because he has played 40+ like our last 3 games, the rest of the starters are hurt and by missing this game he gets a 5 day break.',NULL,126,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.1779,0.156,0.667,0.178),
	 ('2024-02-01','fckthisite','Duh. Kawhi''s resume speaks for itself',NULL,125,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0,0,1,0),
	 ('2024-02-01','Drag0nborn1234','Time to drop him one more rank in the MVP race.','Mavs',125,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.2732,0,0.826,0.174),
	 ('2024-02-01','beer_down','Love this, feel like Cam was KD’s favorite teammate on the Nets','Suns',124,'https://www.reddit.com/r/nba/comments/1ag192x/kd_with_some_friendly_trash_talk_to_his_friend/',0.8658,0.519,0.481,0),
	 ('2024-02-01','PineapplePandaKing','Maybe they''re the skulls of our enemies','Pacers',124,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.4939,0,0.652,0.348),
	 ('2024-02-01','hydroknightking','Tom Brady was listed as “probable” his entire career to the point the NFL changed injury designation rules cause of the way Belichick used the system. Maybe not too relevant but I always find it interesting','Celtics',124,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.3919,0.092,0.858,0.049);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','Lacabloodclot9','Giddey sub won them the game','Grizzlies',123,'https://www.reddit.com/r/nba/comments/1ag14vv/highlight_holmgren_hits_daggers_triple_with_vs/',0.5719,0.425,0.575,0),
	 ('2024-02-01','senor_zanjeer','I love Mikal Bridges','Suns',123,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.6369,0.677,0.323,0),
	 ('2024-02-01','Apollo611','Dame gonna request a trade back','Lakers',121,'https://www.reddit.com/r/nba/comments/1ag3pwx/damian_lillard_loses_in_his_return_to_portland/',0,0,1,0),
	 ('2024-02-01','Daconvix','Feel bad Mikal stuck on this shit Nets team','Warriors',121,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',-0.8442,0,0.397,0.603),
	 ('2024-02-01','tapk69','The problem with this call is that Pat will hound Curry all game without being called for fouls because he is a dawg.
Curry moves a bit to the path of the attacker but the contact is initiated by the attacker. They will call this same play differently depending on the game and players involved, you can bet.','Cavaliers',120,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.7311,0.048,0.808,0.144),
	 ('2024-02-01','AnotherStatsGuy','I don’t know. Those 2 series winners by Dame and the wins against the Nuggets in 2019 are still higher than anything I’ve seen the Pelicans do.','Pelicans',120,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.7783,0.228,0.772,0),
	 ('2024-02-01','TheseWalls_','He better get one before the media gets all over Wemby in a couple of years.','bwLakers',118,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.4404,0.172,0.828,0),
	 ('2024-02-01','0dias_Chrysalis','League really thinks this shit more fun to watch if like 9 guys are averaging 30ppg. Same with them only caring about 6 teams in the media. They really think the league grows by doing all this shit','Bucks',118,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.2183,0.188,0.627,0.185),
	 ('2024-02-01','IEatPussyLikeAPro','They totally did this as a troll. Got out jerked by the NBA team',NULL,117,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',-0.2023,0,0.87,0.13),
	 ('2024-02-01','Losalou52','Luka is the MVP. He is doing the most with the least.  Kyrie has missed 20+ games. Several other starters have missed extended periods. Sometimes he doesn’t play well, but nobody stops him.

He is also 3rd in assists per game, 9th in steals per game, and 23rd in rebounds per game.','TrailBlazers',117,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.743,0.055,0.782,0.162);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','onpc23','What if another violent intruder shows up and slaughters half the staff while the so called employee of the month is at home playing 2k and smoking the good stuff.',NULL,116,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.0516,0.132,0.758,0.11),
	 ('2024-02-01','livelaughloaft','Siakam is a *good* post playmaker, Gasol was a **great** one.','Raptors',116,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0,0,1,0),
	 ('2024-02-01','IanicRR','The greatest few months of my basketball life. I don’t think even another title could top the highs I went through summer of 2019.','Raptors',115,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.7184,0.231,0.769,0),
	 ('2024-02-01','RexFu','https://www.espn.com/nba/story/_/id/39372896/wolves-hornets-game-had-10-missed-calls-final-2-minutes','Timberwolves',115,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0,0,1,0),
	 ('2024-02-01','elliott9_oward5','The fact that players and coaches are being fined for reffing being worse than ever is absurd. If I suck at my job, I get in trouble. They have zero accountability.','76ers',114,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.8271,0,0.749,0.251),
	 ('2024-02-01','Kombuja','If he was hurt in the pacers game he should left during that game.

If he was hurt heading into the nuggets game he should have been on the injury report.

If he was hurt heading into the GSW game he should not have played.

Whether it’s Embiid or the organization this shit is rediculous. Sixers need to get their shit together.','Nuggets',114,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.9737,0,0.7,0.3),
	 ('2024-02-01','jnicholass','Petty? You realize how close Book is with him and Cam right?','Suns',114,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',-0.2869,0,0.836,0.164),
	 ('2024-02-01','InkBlotSam','Exactly. Embiid has been taking shit from the media for years, and it hasn''t affected his decisions on whether or not to play. He''s trying to qualify for the MVP, and trying to help his team who were on a 3 (now 4) game losing streak.','Nuggets',113,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.6239,0.081,0.759,0.16),
	 ('2024-02-01','nbd789','Looks like he was ready to request a trade off the Suns so he wouldn’t have to keep watching that tribute','Timberwolves',113,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.6124,0.217,0.783,0),
	 ('2024-02-01','goingtothegreek','It’s to give an illusion of an unbiased 3rd party auditing calls, when really it’s just “we investigated ourselves and found no wrong doing”. And I, for one, feel like the NBA owes us all money','Timberwolves',113,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.0516,0.122,0.728,0.15);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','MySilverBurrito','Only caught the last 5 mins.

* Grant might be prime Livingston on the middie.

* Lillard badly wanted to have a deep 3 moment lmao.

* "He hit that like a stimulus check" in and out of context is a hilarious playcall.','Heat',112,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.8176,0.26,0.671,0.069),
	 ('2024-02-01','UnhingedSupernova','Teams that Doc Rivers terroroized from within:

1. Lob City Clippers

2. Kawhi Clippers

3. The Process

4. Dame-Giannis Bucks <----- YOU ARE HERE','USA',112,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0,0,1,0),
	 ('2024-02-01','ghost_mv','Miss the twins. I still go back and watch the Cam Johnson 3Pt buzzer beater. Al’s voice is so joyous.','Suns',112,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.685,0.22,0.713,0.067),
	 ('2024-02-01','DyslexicAutronomer','Its a meme, pat bev isn''t the important part. (even tho he was an ex-wolf)

The important part is they have proof of the foul caught on camera which the refs/nba is still ignoring - similar to what happened to the lakers in the original pic.','West',112,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',-0.3786,0.048,0.83,0.122),
	 ('2024-02-01','Nyentzen','This game had some awesome moments for the Subs:
Book doing this to Mikal
KD doing the too small to Cam Thomas
Nurk doing the Mutombo no no

A lot of meme potential',NULL,112,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.1779,0.109,0.773,0.117),
	 ('2024-02-01','KazaamFan','This foul call is horseshit.  It sucks to watch.  Curry did nothing wrong. Can you call this a foul in a pick up game?  Hell no.  ',NULL,112,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.7748,0.08,0.628,0.292),
	 ('2024-02-01','minneapolisboy','Really hope "Marginal Contact" because a rallying cry of some sort lol','Timberwolves',111,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.4391,0.351,0.468,0.181),
	 ('2024-02-01','JAhoops','Better than Tatum',NULL,111,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.4404,0.592,0.408,0),
	 ('2024-02-01','LiveVirus2','The Jan schedule was tough. High quality opponents, 11 road games, 5 b2b’s.

Fuck you and goodbye January.','Thunder',111,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',-0.6124,0,0.75,0.25),
	 ('2024-02-01','deemerritt','I think the worst thing about the nba is the benefit of the doubt the offense gets if they are a superstar. In college lots of refs suck, but you never get the feeling that a specific player is getting calls they otherwise wouldnt.  The easiest thing for them to do would just be to not call shit where the offensive player very obviously is the one initiating contact.

Like i used to love getting tickets to see all the good teams but now ive seen Miami and Philly and i have very little interest watching Butler and Embiid bowl into people and get the call. Like i used to see the lakers as a kid and sure it was frustrating watching shaq shoot all those free throws, but you never got the feeling he was trying to be fouled.','ChaHornets',111,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.9275,0.194,0.662,0.144);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','Get-Some-Fresh-Air','Forfeiting is the solution. When a game is forfeited fans feel ripped off. When fans feel ripped off they stop consuming. It’s the biggest fear for the higher ups',NULL,110,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.4767,0.07,0.765,0.165),
	 ('2024-02-01','Dull_Entrance9946','This is getting overblown. The rule change was good. If players don’t like it, they can bring it up at the CBA or miss out on bonus money in a contract they signed.',NULL,110,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.8074,0.231,0.727,0.042),
	 ('2024-02-01','unknownsoldier9','Aggravated a preexisting injury he was playing through.','Celtics',110,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.5994,0.157,0.348,0.496),
	 ('2024-02-01','Classics22','He''s so sick.  Such a cool dude I wish the front office hadn''t failed him.','TrailBlazers',110,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.5224,0.387,0.438,0.175),
	 ('2024-02-01','WeirwoodUpMyAss','You don’t need to bold that line. Pretty disingenuous when there are multiple paragraphs that accompany it.','',110,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.7003,0.279,0.721,0),
	 ('2024-02-01','CockBronson','Bro…pulling him from the lineup 10 min before the game without a single prior notification of an injury was suspect as fuck and also a big fuck you to paying fans that should have been scrutinized. Put him in the report ahead of time if you know something is up. Yea, he will be questioned for his pattern but at least it doesn’t look like a last minute duck','Nuggets',109,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.4497,0.045,0.828,0.127),
	 ('2024-02-01','DefenderCone97','So close to a very exciting upset. Now I''m disappointed after not expecting to win at the start :(','Nuggets',109,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',-0.8155,0.123,0.457,0.42),
	 ('2024-02-01','ArmiinTamzarian','"Dyson Daniels over me?" Energy','Spurs',109,'https://www.reddit.com/r/nba/comments/1afym20/highlight_jeremy_sochan_pulls_out_the_reverse/',0.2732,0.344,0.656,0),
	 ('2024-02-01','Kazekid','Brolo forgot to the read the script when he took that three instead of Dame','TrailBlazers',108,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0,0,1,0),
	 ('2024-02-01','thecheapseatz','It''s a memeable sound bite and we''re not the basketball geniuses we claim to be','Warriors',107,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','JurgenFlippers','One thing I like about KD is whenever it’s game time he does not care and just locks in. The other stuff comes after the game','Nets',107,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',-0.033,0.089,0.818,0.093),
	 ('2024-02-01','dantheflyingman','His big problem is he was drafted onto a bad team that already had a draft pick deficit. Then he was too good too soon. Every team makes trade/draft mistakes, but the Mavs had very little margin for error to begin with. Other players typically aren''t good that fast and the teams that draft them have a stockpile of draft assets to use when the player is good.','East',106,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.4302,0.149,0.713,0.138),
	 ('2024-02-01','GodsGift2HotWomen365','Nah, his first season with the Clippers he was definitely sitting out game aka load management. 


Some Clipper fans justified it due to degenerative knee disease or something lol


This season he has only missed a couple of games due to a real injury.


What happened to the degenerative knee issue? Lol',NULL,106,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.6808,0.182,0.712,0.106),
	 ('2024-02-01','CockBronson','It’s absurd. He’s scoring 34 ppg and is 1 apg and 2 rpg away from averaging a TD','Nuggets',106,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0,0,1,0),
	 ('2024-02-01','Expulsure','yea he does that and like a different variation of his original one lol','Nets',106,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.765,0.432,0.568,0),
	 ('2024-02-01','MVPiid','Anyways, I''m more interested in fashion anyways. I heard big collars are all the rage these days','76ers',105,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.1548,0.145,0.68,0.175),
	 ('2024-02-01','rookie-mistake','the people''s champ','',105,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',0.4767,0.608,0.392,0),
	 ('2024-02-01','CumAssault','Dyson Daniels clears according to the NBA though somehow

Somehow 5/4/3 on 42/31/65>>> 11/6/4 on 44/37/79','Spurs',105,'https://www.reddit.com/r/nba/comments/1afym20/highlight_jeremy_sochan_pulls_out_the_reverse/',0.0772,0.08,0.92,0),
	 ('2024-02-01','Sharcbait','Wolves still have the Nuggets 3x tho...','Timberwolves',105,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',0,0,1,0),
	 ('2024-02-01','Moist_Walrus5413','Great to see basketball thriving in Minnesota',NULL,105,'https://www.reddit.com/r/nba/comments/1ag2hl8/highlight_target_center_goes_crazy_for_free/',0.6249,0.406,0.594,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','Several_Nature_9593','Marc Gasol is Joel Embiid father.',NULL,104,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0,0,1,0),
	 ('2024-02-01','legend023','Lmao guy at the end is deadass just shaved LeBron James','Pelicans',104,'https://www.reddit.com/r/nba/comments/1afy0gl/nehm_damian_lillard_on_walking_into_the_visitors/',0.5994,0.281,0.719,0),
	 ('2024-02-01','passiveparrot','bro got  gas lit lool','Raptors',103,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0),
	 ('2024-02-01','EnterPolymath','The real magicians are people making his MVP chances disappear. He wasn’t event the player if the week with his all time efficient 73 ffs','Mavs',103,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.2732,0.147,0.671,0.182),
	 ('2024-02-01','harden4mvp13','I actually thought they wouldn’t fine him after he said “I’ll take the fine” reverse psychology don’t work ig 💀','Rockets',102,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.2023,0.096,0.904,0),
	 ('2024-02-01','2coolcaterpillar','Didn’t they do some BS on the Jaylen Brown L2M report a few weeks ago too? What is even the point of it lol','Thunder',101,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.4215,0.113,0.887,0),
	 ('2024-02-01','Pocket_Beans','Lebron made all nba the last two years playing 55 and 56 games','Celtics',101,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.2023,0.13,0.87,0),
	 ('2024-02-01','CoachMorelandSmith','A lot of Memphians became Toronto Raptor fans for about three months in 2019','Grizzlies',101,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0,0,1,0),
	 ('2024-02-01','gigglios','AD missed half a season to force a trade to LA so he isnt wrong necessarily.',NULL,101,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.1575,0.166,0.705,0.129),
	 ('2024-02-01','Shame_On_You_Man','/r/nba’s 180 on this has been something to behold',NULL,100,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','OddToba','Another violent intruder? Shit man, how many Draymond Greens are there in the association…',NULL,100,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.8176,0,0.615,0.385),
	 ('2024-02-01','WobbleKun','lol reminds me of when norm was on the wrong side of the court during tip off.','Raptors',100,'https://www.reddit.com/r/nba/comments/1afy0gl/nehm_damian_lillard_on_walking_into_the_visitors/',-0.0772,0.134,0.718,0.148),
	 ('2024-02-01','DomDomRevolution','Yup and a lot of Sixers fans have rightfully directed their anger at them and the organization. Our medical staff is notoriously incompetent. Anyone paying attention to the Sixers over the years knows this. Do you know how many "day to day" things have turned into players missing months or how much false information we’ve had to wade through? This shit is nothing new and continues to be frustrating as fuck.','76ers',99,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.9584,0,0.771,0.229),
	 ('2024-02-01','CR00KS','I’ll never forget KAT butchering his celebration',NULL,99,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.1695,0.217,0.783,0),
	 ('2024-02-01','fallingleaf271','"It''s Lillard... he got the shot off... LILLARD GOT IT! GOOD! AND THE BLAZERS! WIN THE SERIES! FOR THE FIRST TIME! IN FOURTEEN YEARS!"','Clippers',99,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.8843,0.298,0.702,0),
	 ('2024-02-01','ktran2804','Lowkey love this Clippers team even as a Lakers fan, seeing Kawhi and Brodie win a chip aint so bad in my eyes',NULL,98,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.9311,0.45,0.55,0),
	 ('2024-02-01','GhostRevival','I blame the Sixers organization not Embiid. They’re the ones who weren’t being transparent. I think he was definitely hurting, you could see it in the game against the Pacers.','Pacers',98,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.34,0.082,0.762,0.155),
	 ('2024-02-01','InkBlotSam','Not even 85%. 65 games is only 79% of the season. I''d get fired if I could only show up for 79% of my shifts, these guys think it''s unreasonable to have to show up for at least 3/4 of their shifts to get the highest awards and bonuses possible,  lol.','Nuggets',98,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',0.7003,0.159,0.78,0.061),
	 ('2024-02-01','GooseMay0','LOL. Portland has zero ties to Doc yet they boo him. That''s funny as hell.','Celtics',98,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.2103,0.279,0.521,0.2),
	 ('2024-02-01','CumAssault','To be fair he''s been better at passing because of playing PG. He''s been good from the 4 spot at passing out for 3s, just unfortunately for him he''s like the best shooter on our team and no one can give him assists','Spurs',98,'https://www.reddit.com/r/nba/comments/1afym20/highlight_jeremy_sochan_pulls_out_the_reverse/',0.9001,0.301,0.616,0.083);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','ihateeuge','These people weren''t even watching basketball back then to know lol','Lakers',98,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.4215,0.219,0.781,0),
	 ('2024-02-01','JohnStamosAsABear','The Roman empire probably','Raptors',97,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0,0,1,0),
	 ('2024-02-01','Ok_Buffalo6474','Completely agree. This facade that players can’t play 85% of games is ridiculous. We say the game was harder and more physical back then and those guys played back to backs in the playoffs. Unfortunately some guys have bad injury luck and it’s not on the nba to protect them when fans pay a steep premium. I’m all for if you can’t play don’t but I think it’s more than a reasonable number of games.','Nuggets',97,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',0.4102,0.155,0.724,0.121),
	 ('2024-02-01','samwise141','Ah yes, the fabled 7 year injury that heals when you are into your 30s. Let''s just be real, guy is prioritizing getting the bag and playing in contract years. ','Raptors',97,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.1779,0.135,0.781,0.084),
	 ('2024-02-01','DynamixRo','I''d like to imagine the entire team worked on it, and then sent it to Bev for final approval.','Clippers',97,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',0.6808,0.248,0.752,0),
	 ('2024-02-01','dustinharm','Me when she says she can’t feel anything','Lakers',97,'https://www.reddit.com/r/nba/comments/1ag192x/kd_with_some_friendly_trash_talk_to_his_friend/',0,0,1,0),
	 ('2024-02-01','Askesl','Can you get fined for complaining about a fine?','Nuggets',95,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',0,0.188,0.625,0.188),
	 ('2024-02-01','NevermoreSEA','Brook taking that three honestly broke my brain a little bit.','TrailBlazers',95,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0.0516,0.217,0.58,0.203),
	 ('2024-02-01','xzadetechnoHD','Aaron Wiggins saved basketball again !!','Thunder',95,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',0.5242,0.404,0.596,0),
	 ('2024-02-01','qotsabama','It’s the lack of wins 100%. If Luka had us in a top 3 seed he’d be the unanimous MVP, his stats are absolutely bonkers especially given the efficiency.','Mavs',95,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.7152,0.246,0.685,0.069);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','Pinky1337','Was it mapractice from the medical team? No, its NBA Twitters fault!','Pelicans',95,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.636,0,0.658,0.342),
	 ('2024-02-01','Smekledorf1996','“Omelette du fromage” Dexter, probably',NULL,93,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0),
	 ('2024-02-01','Extwinktimi','Sucks because he really did lead them to a championship path. Played one of the best playoff series I’ve ever seen in my life (watched since Shaq/dwade). 

If he was a toe away from beating the world champs for the knicks, he’d be such a god and would’ve had a 45 minute standing ovation :(',NULL,93,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.7184,0.219,0.653,0.128),
	 ('2024-02-01','LardHop','Bro really put "recently arrested" rondo out of pure spite despite it being irrelevant to his argument lol.','Lakers',93,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',-0.7553,0.107,0.537,0.355),
	 ('2024-02-01','Mysterious_Emotion63','I’m so happy Clippers found out how to succeed with all 4 of the stars still there. I would probably shed a tear if Russ ever won a ring.','Cavaliers',93,'https://www.reddit.com/r/nba/comments/1afz9za/highlight_russell_westbrook_hits_kawhi_with_the/',0.8977,0.331,0.669,0),
	 ('2024-02-01','schadadle','This is just 2 friends and ex-teammates dicking around. More than anything it’s a tribute to Mikal ❤️','Suns',93,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.4767,0.171,0.829,0),
	 ('2024-02-01','Kirk_likes_this','Well also people would have been willing to give him the benefit of the doubt about missing those games if wasn''t a recurring theme that had been going on for years. If Jokic or Curry or Giannis miss a big primetime matchup with an injury everybody''s disappointed but they aren''t skeptical because they don''t do that a lot. Embiid''s five year run of avoiding Denver like the plague is kind of circumstantial but at the same time he could have ended that narrative by playing any one of those games, even if was likely to end in a loss.

If you don''t always play even when it seems like you could have, it uses up all your credibility and then when you actually *have* to take a game off for legit reasons you don''t get that automatic pass that more consistent players do.',NULL,93,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.1308,0.094,0.795,0.11),
	 ('2024-02-01','CockBronson','Go look at this in their sub and this quite literally might as well be one of their takes on the matter.','Nuggets',92,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.296,0.138,0.862,0),
	 ('2024-02-01','floatinginside','The original shitstorm was caused by them not putting Embiid on the injury report in Denver. If he''d been listed as questionable going into that game, and they communicated he was a game-time decision, I don''t think the blowback would have been nearly as bad.

Let me make this clear: this is an awful look for the 76ers org way more than it is for Embiid. No one wants him to play when he''s truly hurt - which is clearly the case here. Had he been listed on the injury report ahead of the Denver game, this would have been avoided. I''m sure some would still say he was ducking Jokic, but it would not have been nearly as bad.','Cavaliers',92,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.8442,0.081,0.769,0.15),
	 ('2024-02-01','mMounirM','why is Giannis even in the game with 5 seconds left. What does he bring at that time down 3?','Raptors',91,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','Sofluous','The fact that Kawhi Leonard has played almost every single game this season now that the 65 rule is in place and he''s in a contract year is fascinating to say the least',NULL,91,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.7096,0.164,0.836,0),
	 ('2024-02-01','johnhenryirons','Used car salesman','Knicks',90,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0,0,1,0),
	 ('2024-02-01','whowasonCRACK2','Typical Russillo- correct, but embarrassingly self serious about it','Lakers',90,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.6124,0,0.583,0.417),
	 ('2024-02-01','CannabisPrime2','Or Milwaukee. The wall we built in front of Giannis was anchored by Gasol','Raptors',90,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0,0,1,0),
	 ('2024-02-01','We_The_Raptors','It''s also so predictable. Had a feeling as soon as it happened there''d be a "the fans forced him to hurt himself" narrative from somewhere','Raptors',90,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.6845,0.063,0.71,0.227),
	 ('2024-02-01','SerenadeSwift','Jokic literally just won an MVP as a 6 seed recently but Luka can’t even sniff the top 5 despite averaging 35/9/8 on 62% TS?','SuperSonics',90,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.5499,0.185,0.815,0),
	 ('2024-02-01','imploding-submarine','You’re absolutely correct and in my head that sentence started with “NBA” for sure

It’s this brand’s specific flavor of basketball I’m finding difficult to stay plugged into',NULL,89,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.0258,0.116,0.804,0.08),
	 ('2024-02-01','TallnFrosty','I mean, this is somewhere between 10% and 20% NBA offenses.','Warriors',89,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.3612,0,0.783,0.217),
	 ('2024-02-01','ilickedysharks','Well for one Kawhi has said this is the first time he hasn''t felt constant pain from his knee, so thats probablya huge reason he can play more games. I also find it hard to believe Kawhi gives a fuck about awards and stuff enough to make the 65 game cut a big priority of his.','Raptors',89,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.6971,0.197,0.695,0.108),
	 ('2024-02-01','IanicRR','And his defence too. I love JV and I would kill to have him back right now. But Philly would have shredded us if Masai didn’t pull that trade mid season for Marc.','Raptors',89,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',-0.0129,0.11,0.808,0.082);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','bravof1ve','This is the truth that these people will ignore.

Embiid slander always does great for engagement, so the national media is of course going to lean into it','76ers',89,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.7845,0.262,0.669,0.07),
	 ('2024-02-01','medievalmachine','You got to pick your spots and ideally only coaches do it. Phil, Steve and Pop always brought out the big guns for the playoffs. Otherwise, you''re just antagonizing people for no reason.','Knicks',89,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.4767,0.072,0.775,0.152),
	 ('2024-02-01','probablymade_thatup','Gasol, Ibaka, Kawhi, and Siakam. That''s such an insane frontcourt on both sides of the ball','Bucks',88,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',-0.4019,0,0.847,0.153),
	 ('2024-02-01','NevermoreSEA','Doc''s secrit plays.','TrailBlazers',88,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.25,0.5,0.5,0),
	 ('2024-02-01','Dusty_Negatives','Bullshit. We matched up w docs clips multiple times. Terry Stotts hated doc and they barbed one another over the years.  It’s not out of nowhere lol.','TrailBlazers',88,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',-0.8842,0,0.69,0.31),
	 ('2024-02-01','Amoeba_mangrove','I get what you mean, but he’s on a guaranteed contract. And likely some form of career health insurance.

You don’t get guarantees for your NEXT contract, before you’ve even done the work for it.

Especially not if you’re injured while other people do the same work.','VanGrizzlies',88,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.438,0.062,0.938,0),
	 ('2024-02-01','SirDiego','Yeah that''s my biggest problem. I can live with them missing things in the moment, they''re human. But to review that play and then say that''s not a foul really feels like I''m being gaslighted.','Timberwolves',87,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.7111,0.21,0.703,0.087),
	 ('2024-02-01','MyNameIsAMeme','We know the San Antonio Spurs hate him, but what does that have to do with Stephen a. Smith??? 🤓','Knicks',87,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.4386,0,0.862,0.138),
	 ('2024-02-01','CockBronson','I’m confused… was Embiid playing injured or did he get injured on the fall?','Nuggets',87,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.5574,0.099,0.604,0.297),
	 ('2024-02-01','THUNDER-GUN04','How many games has Kyrie missed? I''ve heard so little chatter about him, or the Mavs in general.

Edit: Just looked it up, it''s 18. Wow.','Nuggets',86,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.3818,0.127,0.8,0.073);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','TB_016','Spread the gospel. The Scoot takes on this sub have been trash. Blazers needed a national game just for that alone. Now we go back into darkness for the rest of the season lol.','TrailBlazers',85,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',-0.0516,0.076,0.815,0.109),
	 ('2024-02-01','hanyou007','Hey if they are legit injuries they are legit. That’s a shame and sucks. But regardless they still missed anywhere between a 5th to a 3rd of the season. If I miss 3 months of work during the year on LoA you can sure as hell bet I’m not winning employee of the year, no matter how much effort I put in. Same argument applies here. If you want to win awards, you have to be playing. If you miss games, for whatever reason, you dont get awards.','Magic',85,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.6771,0.185,0.582,0.234),
	 ('2024-02-01','wyvern_rider','Mikal Bridges is Devin Booker brother',NULL,85,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0,0,1,0),
	 ('2024-02-01','asapshrank','just the classic 7''2 center hitting the catch & shoot dagger 3 to ice the game, nothing to see here','Raptors',85,'https://www.reddit.com/r/nba/comments/1ag14vv/highlight_holmgren_hits_daggers_triple_with_vs/',-0.34,0,0.876,0.124),
	 ('2024-02-01','zakkwaldo','we would never do dame like that','TrailBlazers',85,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',-0.2755,0,0.74,0.26),
	 ('2024-02-01','TheNumber42Rocks','He put implies because you''re missing the obvious: the teams stop players from playing. SAS brings it up in the video too, that at times teams stop players from playing due to load management.

I''m all for putting this on the players, but we have no numbers or data for who pushes players to sit out more, themselves or the team. It''s beneficial for the owner and the team that the best player stays healthy and that sometimes means sitting out back-to-back games.',NULL,85,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.886,0.164,0.758,0.078),
	 ('2024-02-01','qpwoeor1235','Nah he means literally. He currently makes up 35% of all wizards and hornets viewership',NULL,84,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.1027,0,0.909,0.091),
	 ('2024-02-01','Hank_fuck_yourself','Brad Steven had the 2020 vision. He''s on track to build a dynasty. Ofc I''ve probably jinxed it now lol',NULL,83,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.5859,0.22,0.78,0),
	 ('2024-02-01','soft-cookie','Conley and TA have to go up there too, right? That squad was one of my all time favorites','Timberwolves',83,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.4215,0.135,0.865,0),
	 ('2024-02-01','teh_scarecrow','That was smoother than those PG Erykah Badu edits.','Clippers',83,'https://www.reddit.com/r/nba/comments/1afz9za/highlight_russell_westbrook_hits_kawhi_with_the/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','urfaselol','thats hilarious','NBA',82,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',0.4019,0.73,0.27,0),
	 ('2024-02-01','girlscoutcookies05','50 shots on his last game like Kobe','ChaHornets',82,'https://www.reddit.com/r/nba/comments/1afy0gl/nehm_damian_lillard_on_walking_into_the_visitors/',0.3612,0.263,0.737,0),
	 ('2024-02-01','SweaterMeatMyInbox','The important thing here is that people in Philly managed to find a way to be the victims.',NULL,82,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.128,0.094,0.785,0.12),
	 ('2024-02-01','Basketball_Reference','Most seasons by a center with a VORP of 2 or higher:

|Rk|Player|Count|
|-:|:-|-:|
|1|Shaquille ONeal|15|
|2|Hakeem Olajuwon|15|
|3|Kareem Abdul-Jabbar|14|
|4|Al Horford|12|
|5|Vlade Divac|12|
|6|David Robinson|12|
|7|Robert Parish|11|
|8|Tim Duncan|10|
|9|Dikembe Mutombo|10|
|10|Patrick Ewing|10|
|11|Jack Sikma|10|
|12|Moses Malone|10|
|13|Bob Lanier|10|
|14|Nikola Jokic|9|
|15|Marc Gasol|9|

Provided by [Stathead.com](https://www.sports-reference.com/sharing.html?utm_source=direct&utm_medium=Share&utm_campaign=ShareTool): [Found with Stathead. See Full Results.](https://stathead.com/basketball/player-season-finder.cgi?utm_source=direct&utm_medium=Share&utm_campaign=ShareTool)
Generated 1/31/2024.

Marc Gasol is certainly up there with some of the greats at the position','bbref',82,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.4137,0.041,0.959,0),
	 ('2024-02-01','Phxdwn','That''s like using a wheelchair for the fun of it!','Suns',82,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0.7263,0.465,0.535,0),
	 ('2024-02-01','stancehunters','tbh I thought he retired years ago.

What a career though! He was crucial to winning our 2019 chip','Raptors',82,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.5707,0.187,0.813,0),
	 ('2024-02-01','BlazersMania','https://streamable.com/2yds9h',NULL,81,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0,0,1,0),
	 ('2024-02-01','NotARageComic','There isn’t even a real competition at this point. OG is second in odds and he’s +800; Gobert just dropped to -360.','NBA',81,'https://www.reddit.com/r/nba/comments/1afzqhm/highlight_rudy_gobert_makes_it_difficult_for/',0,0,1,0),
	 ('2024-02-01','carefulmybones','Always and on every single issue',NULL,81,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0),
	 ('2024-02-01','jcar195','Somehow Ben Simmons was involved','Lakers',81,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','BlazersMania','Most likely a bitter sweet* reunion,  we love the man and wish him the best but it''s still hard to see him in a different uniform.  IMO I think our fan base did him right for the prolonged standing o

Edit Spelling',NULL,81,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.7477,0.219,0.701,0.08),
	 ('2024-02-01','zmegadeth','> Averaging a call every 12 seconds is wild on its own.

Is that a true stat??','Grizzlies',81,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.4871,0.196,0.804,0),
	 ('2024-02-01','Schoolboynephew','Whether Portland decided to foul or not, Dame taking the ball out there is incomprehensible. Dame gets the ball and gets to the line on a foul or Dame time from the logo for a decent chance of tying. Just poor awareness all around.','Kings',80,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',-0.2732,0.044,0.887,0.069),
	 ('2024-02-01','classically_cool','r/nba doesn''t watch basketball though',NULL,80,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0),
	 ('2024-02-01','Dunkman77','GG Thunder, love watching your team and I could definitely see a lot of battles coming the next few years.','Nuggets',80,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',0.8038,0.372,0.53,0.098),
	 ('2024-02-01','Suspicious-Row-4248','Also sent 2 games into overtime',NULL,80,'https://www.reddit.com/r/nba/comments/1ag14vv/highlight_holmgren_hits_daggers_triple_with_vs/',0,0,1,0),
	 ('2024-02-01','SpinJitsu259','It’s got to be changed. It’s one of the few things I can’t stand to watch on an nba basketball court. It’s a trained and deliberate strategy of deception on the part of player: initiate contact and flail. It’s no different than the rip-through move that had to eventually be revised. I will be really disappointed in the league if they don’t address it in the offseason.','Pacers',80,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.8173,0,0.878,0.122),
	 ('2024-02-01','JayJax_23','Just fell to my knees in despair in the middle of Target, I''m sorry Mr. Embiid','Wizards',80,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.3818,0,0.795,0.205),
	 ('2024-02-01','ralphwauren','She held me down like Coretta','Raptors',80,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0.3612,0.333,0.667,0),
	 ('2024-02-01','Mahomeboy001','KD made 2nd team All NBA after playing 55 games in 2021-2022, Kawhi made 1st team All NBA after playing 52 games in 2020-2021, Bradley Beal made 3rd team All NBA after playing 60 games in 2020-2021, Paul George made 3rd team All NBA after playing 54 games in 2020-2021','Lakers',80,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.6369,0.135,0.865,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','victheogfan','They really didn’t need to do this','Heat',79,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0,0,1,0),
	 ('2024-02-01','livefreeordont','82+ games played

1983: 40 players

1993: 42 players

2003:  46 players

2013: 28 players

2023: 10 players','76ers',79,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.34,0.124,0.876,0),
	 ('2024-02-01','DubsFanAccount','People did stop watching. Lost half their audience from ten years ago. Just drew less viewers than a women’s college game head to head. Why the NBA isn’t panicking is weird.','Warriors',79,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.7964,0,0.741,0.259),
	 ('2024-02-01','Sampladelic','This is exactly why players like SGA and Wemby will have a better chance to win a ring than Luka.


They both came into teams that fucking sucked. But it allowed OKC to draft and accumulate capital. Wemby will get the same treatment because they will suck for a few more years.','Mavs',79,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.1018,0.134,0.76,0.106),
	 ('2024-02-01','RealPrinceJay','That team fits Luka really well lol','76ers',78,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.6674,0.523,0.477,0),
	 ('2024-02-01','MVPiid','According to Nurse it''s being treated as a new injury on the already injured knee (perhaps a hyperextension).','76ers',78,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.6705,0,0.718,0.282),
	 ('2024-02-01','Brady331','He’s a great FT shooter, everyone knows that','Celtics',78,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0.6249,0.406,0.594,0),
	 ('2024-02-01','syo','What the world done come to','Grizzlies',78,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0,0,1,0),
	 ('2024-02-01','rburp','Man you can''t force a free throw in da world','Lakers',78,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.4023,0,0.748,0.252),
	 ('2024-02-01','jorgelongo2','Sixers medical team is a walking malpractice',NULL,78,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','lets_talk_basketball','Luka is out there playing with tick tockers and twitch streamers',NULL,77,'https://www.reddit.com/r/nba/comments/1ag2hl8/highlight_target_center_goes_crazy_for_free/',0.2023,0.153,0.847,0),
	 ('2024-02-01','MorryD','You ever had to take over a coaching job mid season? I wouldn''t wish it on anyone. Not his fault if his guys don''t step up.','76ers',77,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0,0.085,0.83,0.085),
	 ('2024-02-01','TheAus10','Luka Doncic. (Hopefully)','Mavs',77,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0,0,1,0),
	 ('2024-02-01','KillerWhalePP','They should just let him go play with his nova bros in New York','Suns',77,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.34,0.156,0.844,0),
	 ('2024-02-01','CoachJW','This whole second half has been all Chet. Best he’s looked in weeks.','Thunder',76,'https://www.reddit.com/r/nba/comments/1ag14vv/highlight_holmgren_hits_daggers_triple_with_vs/',0.6369,0.259,0.741,0),
	 ('2024-02-01','_uper_nknown','He’s right. The NBA is an entertainment and so entertain.','Lakers',76,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.659,0.403,0.597,0),
	 ('2024-02-01','InkBlotSam','Also, claiming Embiid forced himself to play because "the whole basketball world was screaming in his ear," is an interesting way to say, "Embiid forced himself to play because he''s in danger of not making enough games to get MVP and really, really, really wants to be MVP again."','Nuggets',76,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.6705,0.122,0.683,0.195),
	 ('2024-02-01','dustinharm','Probably the top 10 other candidates dying. Modern era MVP stats are super inflated and that’s just not Kawhi’s game. He’s not a realistic candidate but I doubt he cares because clips are definitely realistic contenders.','Lakers',76,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.7992,0.261,0.664,0.074),
	 ('2024-02-01','dumdum2727','You do know he dropped 46 in a blowout of Luka and the Mavs literally last week right?',NULL,76,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0,0,1,0),
	 ('2024-02-01','McNuggeroni','Should be 75 games. I have no problem with a player like Mikal Bridges winning MVP. When the divas in the league see that, maybe they''ll show up to work','Bucks',76,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.25,0.17,0.69,0.141);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','Ayjel89','Rough to get the stop you want in a winnable game but don’t clean the glass.',NULL,76,'https://www.reddit.com/r/nba/comments/1ag14vv/highlight_holmgren_hits_daggers_triple_with_vs/',0.6124,0.344,0.573,0.083),
	 ('2024-02-01','BasedAkkarin','Sorry nuggets fans, giddey really tried his best there.','Thunder',76,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',0.6326,0.35,0.548,0.102),
	 ('2024-02-01','swhos','Stats are for nerds.  Doc is all about trusting "his guys".','Clippers',75,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.4019,0.213,0.787,0),
	 ('2024-02-01','OsuLost31to0','He’s actually cooking here','Cavaliers',75,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0,0,1,0),
	 ('2024-02-01','BusterStrokem','You don’t want to lose him. He is…liquid.','Heat',75,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.34,0.13,0.6,0.27),
	 ('2024-02-01','mrobin4850','I’ve watched the least amount of basketball that I have in years for this exact reason. The game no longer feels like a game between two teams instead it feels like each team trying to manipulate the third party (refs) to give them the win. The NBA is losing its ability to create an unbiased game. Defenders should be allowed to retain some personal space without offensive players falling into them and foul baiting all game. It makes for an awful spectrum when the best players in the league are the best because they shoot 15 free throws a night.','Pistons',75,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.9662,0.264,0.645,0.091),
	 ('2024-02-01','landof10000cakes','This Nets organization, is it doing anything Friday night? ','Timberwolves',74,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0,0,1,0),
	 ('2024-02-01','rightfromthegecko','The Doc is in',NULL,74,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0,0,1,0),
	 ('2024-02-01','ShaiFabulousAlexandr','Buddy he was on the lakers for that. This is photoshopped.',NULL,74,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',0,0,1,0),
	 ('2024-02-01','Low_Smile1400','Doc Rivers basketball','Kings',73,'https://www.reddit.com/r/nba/comments/1ag3pwx/damian_lillard_loses_in_his_return_to_portland/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','constantlymat','In European countries salaried employees have around 21 free days per year. Some even have up to 28 or 31.

21/260 is like 8% and you still get your full salary.

Twenty percent is 2.5x as much. On top of that, they have months of free time during the summer which disrupts the picture even further.','Mavs',73,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.872,0.173,0.827,0),
	 ('2024-02-01','Unfair_Application17','Pain. But I’m happy for him.',NULL,73,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.5994,0.451,0.357,0.192),
	 ('2024-02-01','KillingTime_ForNow','What is his fault though is having your best FT & 3 pt shooter inbounding the ball to fucking Giannis when you''re down 3 with 5 seconds to go.','TrailBlazers',73,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.3612,0.14,0.769,0.09),
	 ('2024-02-01','SuckMyLonzoBalls','is that good','Clippers',73,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.4404,0.592,0.408,0),
	 ('2024-02-01','InTheMorning_Nightss','They’re just trying to pass off the blame for their incompetency.','Clippers',73,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.34,0,0.806,0.194),
	 ('2024-02-01','StarryScans','That Raptors team was insane

Danny, Lowry, Pascal, FVV, Ibaka, Marc and OG/Norman/Boucher on support.

And then there''s Kawhi and it was over.','JPN',72,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0,0.102,0.795,0.102),
	 ('2024-02-01','PSUDolphins','2 days ago: this loser needs to stop ducking and play 🤡

Today: can''t believe this loser decided to play while hurt 🤡','76ers',72,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.8689,0.148,0.432,0.42),
	 ('2024-02-01','OstrichDelicious587','Brogdon was a big reason for that from what I saw. Dude was quarterbacking the defense down the stretch grabbing rebounds blocking lobs blitzing Lillard and helping off of Giannis or brook and recovering. That dude was all over the floor.',NULL,72,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.0258,0.087,0.851,0.061),
	 ('2024-02-01','TrRa47','Tbf, that team fits Luka more than Tatum.','Knicks',72,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0,0,1,0),
	 ('2024-02-01','lazzysmalls','The deceleration is IN','NBA',72,'https://www.reddit.com/r/nba/comments/1ag3nvh/highlight_anfernee_simons_with_the_tough_runner/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','Snoo-40231','If JJ Reddick said this people would''ve been praising him','Lakers',72,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.7378,0.438,0.562,0),
	 ('2024-02-01','GarriganGate','It also gives an actual standard to voting 

Rather than someone making an all nba team cause their known or especially liked players when really they didn’t play enough games for their case to be better than another guy’s 

It’s now a standard that needs to be hit. And that is the best way to level the playing field ','Raptors',72,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',0.9281,0.217,0.783,0),
	 ('2024-02-01','KazaamFan','I don’t get all this.  Playing 65 games doesn’t seem like much to ask.  And there should be a cut off imo. Is 65 the best?  Idk. 60?  Can’t really see it going lower than that.  How you gonna win awards if you out 25% of the time?  Unless the team was complete garbage in those games you missed, maybe. ',NULL,72,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.879,0.22,0.672,0.108),
	 ('2024-02-01','the_alert','Because the wolves are good?','Spurs',72,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.4404,0.42,0.58,0),
	 ('2024-02-01','Nugur','Retired from nba maybe.

This tweet said basketball. So he’s done done',NULL,72,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0,0,1,0),
	 ('2024-02-01','ftghb','50%, it''s what superstars default to in crunch time, and it''s up to whether the league likes them enough to honor it','Warriors',72,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.7184,0.231,0.769,0),
	 ('2024-02-01','Betaateb','I think his point is, if you are getting your hardcore fans that watch the NBA literally daily to turn off games, then they are likely losing far more casual fans.

If Russillo can''t stomach it, tons of people probably can''t.  You can see his point around here.  Of course refs have always been criticized but it is getting to a crazy level now where we are watching terrible fouls called and defended by the NBA basically daily.','Nuggets',71,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.8502,0.019,0.852,0.13),
	 ('2024-02-01','Drag0nborn1234','It''s always been a "yeah he averaged 45/10/10 but he only played 3 games so we give it to someone else who played 4 and averaged 29/6/5".','Mavs',71,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.7783,0.271,0.729,0),
	 ('2024-02-01','zmegadeth','gaslighting doesn''t exist that''s just something you made up','Grizzlies',71,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0,0,1,0),
	 ('2024-02-01','DarthNightnaricus','It''s come to my attention that Scoot Henderson is actually good


WHY DID THEY BENCH HIM IN THE SECOND HALF?','Thunder',71,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.4404,0.132,0.868,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','JsonWaterfalls','Having watched my fair share of Mavs game this year just because I love watching Luka, I honestly don''t know how he averages so many assists when his teammates continue to brick wide open shots.

I honestly think he has the worst supporting cast in the league of any star player and I''m not even sure if it''s arguable. Kyrie is fine when healthy but the rest of the team is so incredibly painful to watch.','Pelicans',71,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.2052,0.174,0.707,0.119),
	 ('2024-02-01','GGezpzMuppy','Best experimental PG in the league','Spurs',71,'https://www.reddit.com/r/nba/comments/1afym20/highlight_jeremy_sochan_pulls_out_the_reverse/',0.6369,0.457,0.543,0),
	 ('2024-02-01','buzzcitybonehead','If we didn’t watch basketball, these guys wouldn’t be able to play for a living and wouldn’t have opportunities to get injured','ChaHornets',71,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.3182,0.195,0.7,0.105),
	 ('2024-02-01','Cudizonedefense','Usage rate quite literally *does* include assists…. How is this upvoted','Heat',71,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0,0,1,0),
	 ('2024-02-01','TheWaterBottle10','Best I can do is a pizza party, workload increase, and below-market raise.','Lakers',70,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.8481,0.535,0.465,0),
	 ('2024-02-01','Sharp_Aide3216','Ben Simmonesque  assist right there.',NULL,70,'https://www.reddit.com/r/nba/comments/1afz9za/highlight_russell_westbrook_hits_kawhi_with_the/',0,0,1,0),
	 ('2024-02-01','BubbaTee','Derrick Henry could probably average 20 in the NBA just charging into defenders for FTs.',NULL,70,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.0772,0.085,0.915,0),
	 ('2024-02-01','PanthalassaRo','Plenty money','Knicks',70,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0,0,1,0),
	 ('2024-02-01','Hay-blinken','It makes no sense. So annoying as a fan of the team.','76ers',69,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.3878,0.163,0.508,0.33),
	 ('2024-02-01','Ok_Excuse_3695','They almost definitely gave him $25k for post game comments thats standard and tacked on an additional $15k for getting caught saying “cheating ass refs”','Timberwolves',69,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.2716,0.083,0.796,0.121);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','defiantcross','ah nice.  adding to his taunt set','Suns',69,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.4215,0.318,0.682,0),
	 ('2024-02-01','night_dude','Man, as a defender in soccer, I don''t understand people who don''t like defending. It feels great to shut people down. It''s half of almost every team sport.

I know, different strokes for different folks, etc etc. But still. It can be just as glamorous and satisfying (particularly in bball when you can reject people at the rim) as attacking play.','Bucks',68,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.7347,0.206,0.672,0.122),
	 ('2024-02-01','FERFreak731','He''s saying facts.','Jazz',68,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',0,0,1,0),
	 ('2024-02-01','Mediocre-Example7947','And that’s how it has always been. When guys like KD and LeBron were younger they were iron men. It wasn’t until the Achilles injury that KD started playing less games and being more careful about soft tissue injuries.

The main culprit is Kawhi who has been load managed his entire career. And you can probably blame that on Pop. And the other culprit is AD who hasn’t been able to play through a paper cut.',NULL,68,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.0754,0.102,0.811,0.087),
	 ('2024-02-01','jackaholicus','Well that''s the top player vs top 15 players. It''s possible that Haliburton could be the 15th most valuable player in the league even if he only played 60 games. Especially if he were to be "replaced" by someone playing 65','Mavs',68,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',0.8832,0.275,0.725,0),
	 ('2024-02-01','Kettleontherocks','Jordan took the responsibility of being a superstar seriously. It wasn’t just about performing at an all time level, it was about showing up and putting on a show because some kid out there might have never seen Michael Jordan play before and he felt like he owed it to that kid to play and play his best, whether it was him at his absolute prime or some “washed up” version of himself later on.',NULL,68,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.9042,0.168,0.811,0.021),
	 ('2024-02-01','ASK_ABT_MY_USERNAME','There literally is not a worse possible call than that','Warriors',67,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.3724,0.242,0.758,0),
	 ('2024-02-01','vasinsavin','[https://i.imgur.com/cUAph2B.png](https://i.imgur.com/cUAph2B.png)

timeout right after','Suns',67,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0,0,1,0),
	 ('2024-02-01','BenShelZonah','My friend lived in Portland for a few years and didn’t watch basketball. She said everyone in the city knew who he was and loved him. I always thought that was really cool',NULL,67,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.8655,0.257,0.743,0),
	 ('2024-02-01','jaslr','https://www.youtube.com/watch?v=UzQP7u-IOxg the fun starts at 1min25secs...','Mavs',67,'https://www.reddit.com/r/nba/comments/1afy0gl/nehm_damian_lillard_on_walking_into_the_visitors/',0.5106,0.398,0.602,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','MC-Jdf','The Bucks had a turnover in each of their first 6 possessions of the 4th quarter. That''s basically game any time.','Warriors',67,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0,0,1,0),
	 ('2024-02-01','SonicdaSloth','Think it’s more media.   Jefferson basically calling him a pussy on air during game.  Stuff like that','76ers',67,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.3612,0.143,0.857,0),
	 ('2024-02-01','RealPrinceJay','In theory, but this is the problem with a hard cutoff. Lets'' say Hali plays 62 games and misses the cutoff, but someone else played 65. In terms of value they didn''t really deserve it anymore because of 3 games','76ers',66,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.296,0.18,0.664,0.156),
	 ('2024-02-01','KiryuXGoro','Lakers please trade for Pat Bev before your next game.','Clippers',66,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',0.3182,0.204,0.796,0),
	 ('2024-02-01','PaulGeorgeFan1','harden basically sacrificed his hamstring for the team so','Clippers',66,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0,0,1,0),
	 ('2024-02-01','LeBremsstrahlung','He left a party at Matt Leinart''s house because nobody was watching the college football game lol','Mavs',66,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.6705,0.282,0.718,0),
	 ('2024-02-01','jocro','Yeah he averaged 43.6/8.7/7.6/2.1 over 14 games in January, one of the most unstoppable scoring stretches in history.

Over 40 games from December through February he was at 39.3/7.2/7.0/2.1

All this while being an absolute *ironman*, playing 78/82 games that year and averaging nearly 37 MPG. Just one of the upper echelon carry jobs by any star.','Thunder',66,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.228,0.067,0.899,0.035),
	 ('2024-02-01','floatermuse','For anyone curious that''s a TS% of [67.1%](https://www.statmuse.com/nba/ask?q=kawhi+last+25+games+ts%25) not counting the 25th game which is today',NULL,66,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.3182,0.141,0.859,0),
	 ('2024-02-01','pgm123','You can just redefine it. Legal guarding position was enforced differently in the ''70s.','76ers',66,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.128,0.103,0.897,0),
	 ('2024-02-01','RezLifeGaming','Why does it look like everyone got a gun to they head making sure they clap hardly no actual cheering looks like a lot people thinking I better clap so it don’t look bad',NULL,66,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.6629,0.301,0.522,0.177);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','ELITE_JordanLove','Boo fucking hoo you got shortchanged on a contract, staying healthy has value and you couldn’t provide that. Not to mention these are already max-tier players, I don’t feel bad about them making $50M a year instead of $60M.',NULL,66,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',0.1531,0.123,0.793,0.084),
	 ('2024-02-01','tayroarsmash','Idk I’ve been on board with Stephen A ever since he called Jason Whitlock a fat piece of shit. It’s all nonsense anyway and Stephen A has charisma','Thunder',65,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.7717,0,0.741,0.259),
	 ('2024-02-01','Turbo2x','You guys don''t understand. Embiid cares more about the opinions of redditors and twitter users more than his colleagues, coaching staff, and medical team. He''s TOO dialed in to the fans.','Wizards',65,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.357,0,0.924,0.076),
	 ('2024-02-01','cantcooklovefood','They could’ve ran it on mute. That would’ve been hilarious','Lakers',65,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.4019,0.231,0.769,0),
	 ('2024-02-01','ZoroChopper10','Couldn’t happen to a better player, got his coach fired and gave doc rivers 40 million  to do nothing lol',NULL,65,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',-0.4646,0.117,0.644,0.239),
	 ('2024-02-01','Mediocre-Example7947','It wasn’t just nobodies on Reddit and Twitter. It was sports media saying it too.',NULL,65,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0),
	 ('2024-02-01','LinuxDootTP','his work ethic is incredible. he just got in the gym and stayed in the gym all offseason. got himself right and now hes playing the best basketball hes played in years.','TrailBlazers',65,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.8126,0.225,0.775,0),
	 ('2024-02-01','BlueJays007','Those are normal sized collars, find a new slant','Celtics',65,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0),
	 ('2024-02-01','CantaloupeCamper','For the record the promotion is:

>Every time an opposing player on the visiting team misses 2 consecutive free throws in the 4th quarter, everyone with the Timberwolves app will score a free Chick-fil-A Original Chicken Sandwich! Get the Timberwolves app to receive your offer.

https://www.nba.com/timberwolves/bricken-for-chicken','Timberwolves',65,'https://www.reddit.com/r/nba/comments/1ag2hl8/highlight_target_center_goes_crazy_for_free/',0.807,0.18,0.783,0.037),
	 ('2024-02-01','NevermoreSEA','Ant shoots so well in the clutch. Dame really taught him well.','TrailBlazers',65,'https://www.reddit.com/r/nba/comments/1ag3nvh/highlight_anfernee_simons_with_the_tough_runner/',0.6686,0.354,0.646,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','creamcitybrix','L2M report is propaganda.','Bucks',64,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.25,0,0.6,0.4),
	 ('2024-02-01','Amoeba_mangrove','I guess so, but you have to make the cutoff somewhere. Like if it’s 55-65 does it make a difference?

As much as it may screw some people over on an individual basis, if the floor is the same for every player in the league I think it’s fair.

And in my opinion if someone who plays 65 games makes the all nba cut over Tyrese, and whoever else played even MORE games than 65, then they probably deserve it.','VanGrizzlies',64,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.8201,0.136,0.816,0.049),
	 ('2024-02-01','garythegoat72','What do you think he''s thinking about right now?',NULL,64,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0,0,1,0),
	 ('2024-02-01','Iron_Maniac','MEAT ITCH','Thunder',64,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',0,0,1,0),
	 ('2024-02-01','CryptoMemeEconomy','Agreed, but it''d be closer than you think using pure counting stats as the metric. Luka puts up huge numbers because his team sucks comparatively. Tatum can regularly take quarters off or dick around in the regular season because his team is on fire.','Celtics',64,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.8074,0.083,0.718,0.199),
	 ('2024-02-01','LeagueReddit00','>> financially impacted

Who cares if you are financially impacted for not doing your job?','Lakers',64,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',0.4588,0.176,0.824,0),
	 ('2024-02-01','tuckastheruckas','he talks about most sports, but the only sport he really knows is basketball.','Pistons',64,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0,0,1,0),
	 ('2024-02-01','Positive_Parking_954','I heard something from my girlfriend at the time''s parents that really stuck with me, "you''re birthday is the one day of the year that isn''t for you. It''s for the people who love you despite what you do on the other 364."',NULL,63,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.4417,0.09,0.86,0.049),
	 ('2024-02-01','WusijiX','Bigfoot footage','Suns',63,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0,0,1,0),
	 ('2024-02-01','CryptoMemeEconomy','Defensive gap is true, but I think that''s easier to hide with Luka playing PG. The playmaking gap between Tatum and Luka is big too (Tatum is B or B+ while Luka is S-tier), and ultimately, that matters more in high pressure playoff situations than being below average on defense. Defense is more replaceable. You simply can''t trust Tatum with the ball as much as you can Luka with 1 min on the clock. This is ultimately why I think Luka is the better and more valuable player overall right now.

Of course, with all this being said, the average fan probably underrates Tatum in relation to Luka because "box score lol".','Celtics',63,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.92,0.193,0.738,0.068);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','goingtothegreek','This was still one of the dumbest calls I’ve ever seen in an NBA game and it’s so inconsistent it’s wild.','Timberwolves',63,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.5106,0,0.858,0.142),
	 ('2024-02-01','Expensive_Bass_6979','Seriously, I don’t know how anyone who is a fan of the NBA wouldn’t like this rule.  I’m all for player empowerment and people getting their money but just seems like the last 5 years guys stopped giving a shit as much about the fans who are responsible for their paychecks.  Just glad that it’s starting to shift back and we have guys like Tatum and Edwards who are voicing how important it is to play every game regardless of who the opposition is',NULL,63,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.9398,0.248,0.668,0.084),
	 ('2024-02-01','jkure2','My Jim boylen senses are tingling','Bulls',63,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0,0,1,0),
	 ('2024-02-01','512fm','The irony is sitting out a few more games to properly get right makes it look far less like he was ducking Jokic.','Pistons',63,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.2516,0.094,0.854,0.051),
	 ('2024-02-01','deemerritt','People went crazy because UNC had a player pick up 5 fouls in 8 minutes who isnt exactly known for aggressive defense and then they swallowed their whistles at the end of the game.

Also because Teddy Valentine does shit like this https://twitter.com/KeepingItHeel/status/1752518731966677352/photo/1


Also RJ was runnning in a straight line as opposed to the play Russilo commented on. Thats a block 100% of the time.','ChaHornets',62,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.4939,0.116,0.738,0.146),
	 ('2024-02-01','xpillindaass','damn he really hates kawhi lmao basically suggested he was load managing in the playoffs','Clippers',62,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.1851,0.189,0.544,0.267),
	 ('2024-02-01','Coltshokiefan','He watches more basketball than 99% of fans do. I get what he means here, if it makes your die hard viewers want to stop watching, it’s a problem.','Magic',62,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.836,0.039,0.657,0.304),
	 ('2024-02-01','WusijiX','Former teammates aren''t always friends clearly','Suns',62,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',-0.5875,0,0.454,0.546),
	 ('2024-02-01','I-only-play-rubick','LMAO at the staff who tried to stay out of the video at the end of the clip',NULL,62,'https://www.reddit.com/r/nba/comments/1afy0gl/nehm_damian_lillard_on_walking_into_the_visitors/',0.6841,0.214,0.786,0),
	 ('2024-02-01','Mindless-Rooster-533','I''ve been on board with Stephen a ever since he argued with a grown ass man about the movie Cars and then ended the argument with saying "I''m not going to argue with a grown ass man about the movie Cars"',NULL,62,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.8739,0.043,0.702,0.255);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','BettaMom698','Russ layup is a 50/50 no matter the difficulty',NULL,62,'https://www.reddit.com/r/nba/comments/1afz9za/highlight_russell_westbrook_hits_kawhi_with_the/',-0.5423,0.103,0.467,0.43),
	 ('2024-02-01','Brady331','Why would Adrian Griffin do this','Celtics',62,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0,0,1,0),
	 ('2024-02-01','Connect-Blacksmith99','Hard to be DPOY when your team gives up 130 points a night','Timberwolves',62,'https://www.reddit.com/r/nba/comments/1afzqhm/highlight_rudy_gobert_makes_it_difficult_for/',-0.1027,0,0.887,0.113),
	 ('2024-02-01','Vonbonnery','The issue was the Mavericks were bad enough to get a top 5 pick, but because of how good Luka got so quickly they were never going to be bad enough to get any more lottery picks. It would be hard for anyone to build a championship roster starting with a bottom 5 team that then only got picks in the 15-20 range year after year.','Mavs',62,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.128,0.125,0.757,0.118),
	 ('2024-02-01','lost_in_trepidation','Brunson wasn''t that good till his final year with us and then he left.

Go look at KP''s game log with us. He was never healthy.','Mavs',62,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.5667,0,0.837,0.163),
	 ('2024-02-01','LiaM_CS','They should be nobodies too as far as he’s concerned

Their opinions should have no bearing on whether he risks his health or not','Nets',62,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.5106,0,0.837,0.163),
	 ('2024-02-01','TJHookor','I remember watching that live.  I''m not a Min or NYC fan but I think I shouted at the TV because of how stupid that call was.  KAT never even made contact with Brunson.  How can it possibly be a charge if you literally do not touch the person?','Mavs',62,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.6059,0.034,0.87,0.095),
	 ('2024-02-01','KaleAdditional776','They are taking advantage of their schedule. They don’t play till Saturday so by taking this game to rest Luka and company will have 5 days of rest. Plus he’s been overworked by a ton the past few weeks.','Mavs',61,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.5267,0.112,0.888,0),
	 ('2024-02-01','IAmReborn11111','I think he''s referring to die hard fans who watch as much as him when he says "me", not specially himself',NULL,61,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.6486,0,0.773,0.227),
	 ('2024-02-01','lord_kupaloidz','I especially remember Mikal''s interview after being traded.

"That''s Kevin Durant."','bwPhx',61,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','floatermuse','Luka should obviously be higher than 7th(with Embiid being likely out he’s a top 4 candidate) but realistically to actually win the award he needs at least the 6th seed I think      

Voters aren’t going to support a candidate who’s on a play in team no matter what because that would mean at the time of voting(after game 82) they could still potentially miss the playoffs',NULL,61,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.9377,0.249,0.69,0.061),
	 ('2024-02-01','SpeclorTheGreat','Comparing Tatum to Kawhi is so disrespectful to Kawhi.','Knicks',61,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0,0,1,0),
	 ('2024-02-01','xzadetechnoHD','First time he’s been given more than about 8 minutes playing time career high 12 points','Thunder',61,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',0.2023,0.114,0.886,0),
	 ('2024-02-01','iPlowedUrMom','You joke, but that is my dream birthday.

Acknowledge it, gift me something small or meaningful, buy me a coffee, and then honestly just let me fuck off by myself for a while.

I say this though as a very fortunate son, dad, and husband, who has a very full life and schedule. So quiet time is just lovely.',NULL,61,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.962,0.325,0.612,0.063),
	 ('2024-02-01','SixGunChimp','AD has played more games than all of them over the past year...','Lakers',61,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.34,0.167,0.833,0),
	 ('2024-02-01','BubbaTee','Yup, it''s why you see Wilt shooting fadeaways and Kareem shooting skyhooks in those old videos, instead of just lowering their shoulders and running into defenders to get easy FTs and dunks.

Because refs actually called offensive fouls in those days.',NULL,61,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.2023,0.091,0.801,0.108),
	 ('2024-02-01','PensiveinNJ','Been saying it for a while but "marginal contact" is the NBA''s new way of excusing shit officiating when they don''t want to be called out on it.','76ers',60,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.7378,0,0.8,0.2),
	 ('2024-02-01','SometimesIComplain','Pleeeease do well in the playoffs this year Wolves, I need my man Rudy to crush those narratives','Jazz',60,'https://www.reddit.com/r/nba/comments/1afzqhm/highlight_rudy_gobert_makes_it_difficult_for/',0.128,0.112,0.802,0.086),
	 ('2024-02-01','Thunder-ten-tronckh','Watching Marc, Mike, Tony and Zbo gut out wins in the GNG era were some of my favorite sports memories man. Sad how it all flies by :(

We were lucky to enjoy his prime in Memphis.','Grizzlies',60,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.7717,0.256,0.624,0.121),
	 ('2024-02-01','CumAssault','But their own internal metrics show they''re so good!','Spurs',60,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.7509,0.403,0.597,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','kalebglover','Scoot had 15 points on 6/9 fg in 13 minutes in the first half and only got 9 minutes in the second half','TrailBlazers',60,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0,0,1,0),
	 ('2024-02-01','whythehellknot','Don''t a lot of them vote for awards that have an impact on players contracts. It''s also not as if the general narrative surrounding a guy hasn''t played a role in trades/contracts/legacy.

They are far more than the nobodies like you and me.','Heat',60,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.5368,0.123,0.831,0.046),
	 ('2024-02-01','stoodis-','This is literally the "Boy Who Cried Wolf" fable. It is *exactly* the same moral lesson of that story.

Instead of a boy crying "WOLF! WOLF!" for attention and the town ignoring his cry when the wolf actually appears, it''s crying "INJURY! INJURY!" to avoid tough games, but when he has a legit injury people ignore it.

This is a lesson you learn as a literal child: when you make yourself known as a liar or an embellisher, people are going to treat you as a liar and embellisher even when you are telling the truth.','Magic',59,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.9646,0.057,0.68,0.262),
	 ('2024-02-01','ashkpa','No. There were 12 missed or wrong calls made in the final 2 minutes of one of our games. People have been misrepresenting that number because at face value it could look like that means they called an incorrect foul every 12 seconds, without realizing the number also includes fouls they didn''t call.

The league is unseriousness and refs are certainly on the take, but facts matter when calling out their bullshit.','Timberwolves',59,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.705,0.107,0.762,0.131),
	 ('2024-02-01','Im__Ron__Burgundy','Doc not doing anything to change the narrative by having the inbound go to Giannis there

(Is this the thread that stays up?)','Celtics',59,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0,0,1,0),
	 ('2024-02-01','F-ck_spez','Jfc. Why did i choose this year to return to nba fandom

Edit: for reference, I''m a Vikings fan, so i didn''t want to re-hitch my bandwagon to another stressful home team. This MN championship drought got me hornier than a Mormon teenager.','Timberwolves',59,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.1026,0.116,0.778,0.107),
	 ('2024-02-01','sad_and_small','It is hard, but also there have been a lot of unforced errors, bad signings, bad trades, and the catastrophic loss of Jalen Brunson.

The Mavs have definitely done a bad job building around Luka.',NULL,59,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.9728,0.065,0.46,0.475),
	 ('2024-02-01','512fm','Most people on this sub will tell you just how great a state the game is in but I really don’t know if you’d agree if you were watching 10 years ago. There’s multiple things with the product that are just off.','Pistons',59,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.7003,0.132,0.868,0),
	 ('2024-02-01','LiveVirus2','Not getting that timeout on the inbound was huge.','Thunder',59,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',0.3182,0.223,0.777,0),
	 ('2024-02-01','KeithVanBread','It should be a permanent alternate','Nets',59,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','yomama1211','Yeah in baseball you can put up whatever numbers you want but your ass better play a comparable amount of games or you’re not making the all star team lol',NULL,58,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.7684,0.326,0.559,0.115),
	 ('2024-02-01','Nyhrox','I have never seen someone who isn''t happy to get chicken','Warriors',58,'https://www.reddit.com/r/nba/comments/1ag2hl8/highlight_target_center_goes_crazy_for_free/',-0.4585,0,0.75,0.25),
	 ('2024-02-01','SquimJim','Not saying we should change the rule, but these guys weren''t winning awards when they were sitting out a ton of games.','Celtics',58,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.7835,0,0.734,0.266),
	 ('2024-02-01','starfruit213','Just makes the league look even more sus','Timberwolves',58,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0,0,1,0),
	 ('2024-02-01','EliteSoccerNinja','This is lit','Grizzlies',58,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0,0,1,0),
	 ('2024-02-01','HashCollector','Jokic with 9 in 9 seasons is wild',NULL,58,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0,0,1,0),
	 ('2024-02-01','collinCOYS','The whole premise behind fining players for being critical of refs doesn''t make any sense to begin with','Timberwolves',57,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.3182,0,0.881,0.119),
	 ('2024-02-01','knowtoriusMAC','The season was only 72 games that year(20-21) and there was a 75 day offseason.

I like the rule but using that year as a baseline is ridiculous.','Knicks',57,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.3612,0.062,0.821,0.116),
	 ('2024-02-01','Goducks91','That was all Brogdon','TrailBlazers',57,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0,0,1,0),
	 ('2024-02-01','imcryptic','Meanwhile Embiid is a cool 200 total points behind the leader Shai and isn’t even in the top 5 for the season.','Mavs',57,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.4767,0.186,0.814,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','KingJoe7-123','You act like most players just call out for no reason lmao. The majority of the time it’s WORK RELATED INJURY as to why they don’t play all 82 games. If you were going to your job and risked breaking or tearing ligaments everytime you clocked in and then were restricted from getting a pay raise if you got hurt, then you wouldn’t like it very much either.',NULL,57,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.4084,0.136,0.684,0.18),
	 ('2024-02-01','SandyMandy17','Idk if he would’ve tbh

He’s low key always been an assist fiend

He gets off to getting other guys involved','Thunder',57,'https://www.reddit.com/r/nba/comments/1afz9za/highlight_russell_westbrook_hits_kawhi_with_the/',-0.3612,0,0.844,0.156),
	 ('2024-02-01','MetroExodus2033','They bring up Pop''s responsibility in all of this, and they''re right about that. He was the first person to initiate load management in the league. And I remember the exact game he did that and the circumstances. They brought that up on First Take too, and how the decision to load manage the Spurs'' stars cost Pop the Olympics'' coaching job while Stern was the commissioner.

Stern did not like where all of this load management was going. He knew it was antithetical to the fan experience.

Silver doesn''t give a fuck. That dude gets such a pass and yet I think he''s at least as bad as Goodell as a commissioner. Probably worse.

This is a player driven league. The player''s association has a lot of power.

These load managment issues are 90% driven by the players now. And on top of that, we''ve had more than one player just outright refuse to play (Kyrie and Ben Simmons).  Those dudes weren''t even hurt. Kyrie just decided not to play for literally half of a season...and he was rewarded for it!  Ben Simmons quit. He literally quit.  And he was rewareded for it!

I''m not about to listen to any bullshit about how this isn''t on the players. This is on the players.',NULL,56,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.3818,0.081,0.855,0.065),
	 ('2024-02-01','StabilitySpace','That Raptors team has one of the greatest defenses of all time, thanks in large part to him anchoring it.

Without doubt the second most important player on the team after Kawhi.','NBA',56,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.9001,0.325,0.675,0),
	 ('2024-02-01','CMYGQZ','Not even the finals, the conference finals will be tough, don’t think you guys can beat Embiid with JV lol.','Grizzlies',56,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.3182,0.126,0.807,0.067),
	 ('2024-02-01','rexter2k5','I think Russillo lives the dream of any average 22 yo fraternity bro.

He lifts, he watches sports, he gets paid to talk about said sports. Every time I watch a video stream of his pod, he''s in a different hotel room.','TrailBlazers',56,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.25,0.051,0.949,0),
	 ('2024-02-01','LeBrown_James666','Mini🤏','Suns',56,'https://www.reddit.com/r/nba/comments/1ag192x/kd_with_some_friendly_trash_talk_to_his_friend/',0,0,1,0),
	 ('2024-02-01','Epicapabilities','Anthony Edwards casually fined more money than I''ve seen in my entire life','Timberwolves',55,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.1779,0.124,0.876,0),
	 ('2024-02-01','choonghuh','Screen blurry as hell for some reason... ','TrailBlazers',55,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',-0.7184,0,0.455,0.545),
	 ('2024-02-01','crichmond77','It’s medical teams all the way down',NULL,55,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','curry30steph-','> It''s pretty much NBA protocol to do a tribute video to a former player. It''s that simple. Not a big deal.

No it’s actually not. Actually so many role players for example don’t get shit which is ok btw

Edit: just because a few role players you like get tribute videos doesn’t negate the fact that many role players still don’t get anything',NULL,55,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.6355,0.145,0.801,0.053),
	 ('2024-02-01','Ok_Assumption5734','Thank God LeBron won that lock down title or darvin would be dead by now ',NULL,55,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0.4588,0.352,0.466,0.182),
	 ('2024-02-01','floatermuse','Honestly it’s so stacked that the team fits everyone lol ',NULL,55,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.7003,0.42,0.58,0),
	 ('2024-02-01','AMJVC15','Was the glue for that 2019 title run, don''t win it without him','Raptors',55,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',-0.4717,0,0.796,0.204),
	 ('2024-02-01','Thimit22','https://www.youtube.com/watch?v=aiVX6siNqEE

Pat Bev did this last year

Ant just got fined $40,000 for saying the refs weren''t calling fouls for us in the Wolves/Thunder post game after SGA blatantly held Ant''s arm on a dunk late in the game. There were a few other missed calls too','Timberwolves',55,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',-0.296,0,0.952,0.048),
	 ('2024-02-01','bsanchey','Remember when Fraudsdales friends in the media were blasting the Knicks for firing him. Bruh a no name coach from the backwaters of basketball was out coaching him with the same talent.

Pepperidge farm sure remembers.','Knicks',55,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0.5574,0.192,0.701,0.107),
	 ('2024-02-01','Jjohn269','As opposed the it being a horrible look when he was sitting out.

Lose-lose situation unless these clowns make up their minds',NULL,55,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.5423,0,0.851,0.149),
	 ('2024-02-01','IAP-23I','Bullshit comments like this getting upvotes is crazy','Knicks',55,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.5719,0.182,0.365,0.453),
	 ('2024-02-01','is-Sanic','How the fuck is he not even in the argument for MVP.

Stuck behind Shai!?! Like, be serious.','NBA',55,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.7494,0.098,0.512,0.389),
	 ('2024-02-01','LaMelgoatBall','I can’t believe that they’d rather fine players than just fix the fucking problem','Celtics',54,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.2944,0.114,0.697,0.19);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','alpacamegafan','Sochan: "NBA can suck my dick for all I care"','Pelicans',54,'https://www.reddit.com/r/nba/comments/1afym20/highlight_jeremy_sochan_pulls_out_the_reverse/',-0.4588,0.208,0.39,0.403),
	 ('2024-02-01','jackattack_99','The West is STACKED man. Luka, Jokic, Shai playing out of this world. And you just casually have Lebron, KD, Kawhi, and Curry there too.','Celtics',54,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.3612,0.132,0.868,0),
	 ('2024-02-01','pf1234321','College rules are much more favorable to the defense, but the problem is that college players aren''t very good so it can lead to lots of ugly games.

NBA should probably be treated more like college games because the players are good enough to overcome the defense even if you give the defense a slight advantage.

College should have more freedom of movement to help the guys put the ball in the hoop',NULL,54,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.7233,0.234,0.614,0.152),
	 ('2024-02-01','National_Sand_9650','A rat''s anus?',NULL,54,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0),
	 ('2024-02-01','Zombiepirate86','Refs ignore rules all the time.


Just last Denver/Milwaukee game Giannis took more than 10 seconds to shoot almost every FT... they put a clock up, he was only called once. Same happens for lane violations. Some players get Ts for barely anything other players get into refs faces and get nothing. ','Nuggets',53,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.8074,0,0.853,0.147),
	 ('2024-02-01','yung-bumstain','If everybody''s scoring 30, nobody''s scoring 30.','Knicks',53,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0,0,1,0),
	 ('2024-02-01','ProsecUsig','Basketball state','Mavs',53,'https://www.reddit.com/r/nba/comments/1ag2hl8/highlight_target_center_goes_crazy_for_free/',0,0,1,0),
	 ('2024-02-01','BehavioralSink','Yeah, I’m opting-out of my season tickets next year 100% because of how terrible the officiating is, and totally not because I don’t feel like paying $$$ to watch every game of a rebuilding team.','TrailBlazers',53,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.1531,0.124,0.794,0.082),
	 ('2024-02-01','tapk69','The East is finally fun again.','Cavaliers',53,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0.5106,0.398,0.602,0),
	 ('2024-02-01','WusijiX','You are legally required to say that tho','Suns',53,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.1027,0.167,0.833,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','defiantcross','nah, foster is the cat and cp3 is the laser pointer light. suns dont worry anymore about him.','Suns',53,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.2514,0.121,0.808,0.071),
	 ('2024-02-01','shaad20','Lol the ptsd is showing','Suns',53,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.4215,0.412,0.588,0),
	 ('2024-02-01','Chili-Lime-Chihuahua','It was Frank Vogel. Maybe they meant that since LeBron and LA won at least that one title, it''s muting criticism and ill will about wasting LeBron''s time with the Lakers.',NULL,53,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',-0.5719,0.095,0.691,0.215),
	 ('2024-02-01','homiez','Was this his best game? he played pretty well','Nuggets',53,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',0.8979,0.704,0.296,0),
	 ('2024-02-01','shinobi_jay','I’m sayin 😭. “Ion won’t no kid”',NULL,52,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.296,0,0.732,0.268),
	 ('2024-02-01','iDestroyedYoMama','Agreed and Beal is weird too. He’s been legit hurt. If he could play he would. He’s playing through a broken nose right now. Our team loves ballin.','Suns',52,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.2023,0.262,0.524,0.215),
	 ('2024-02-01','dedbeats','False. They are bad','Knicks',52,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',-0.5423,0,0.462,0.538),
	 ('2024-02-01','OstrichDelicious587','If that’s true they’re clueless. They needed a three. Tbh Giannis didn’t even need to be on the floor; there were 4 seconds left',NULL,52,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0.0772,0.111,0.791,0.099),
	 ('2024-02-01','AshenSacrifice','Imagine us asking for full pay and bonuses while missing 25% of work. Sounds ridiculous and insane doesn’t it','Braves',52,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.4939,0.136,0.53,0.333),
	 ('2024-02-01','TrickiestToast','Wasn’t that started because the falcons mislabeled Vick before a game so Belichick said fuck you and just started listing him as probable?','Celtics',52,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.5809,0,0.848,0.152);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','Dudedude88','I didn''t know this happened. That''s freaking hilarious','Wizards',52,'https://www.reddit.com/r/nba/comments/1afy0gl/nehm_damian_lillard_on_walking_into_the_visitors/',-0.0258,0.257,0.476,0.267),
	 ('2024-02-01','swawesome52','To the NBA, it''s more appropriate to choke a dude to the ground than it is to criticize officiating.','Timberwolves',52,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.7479,0,0.715,0.285),
	 ('2024-02-01','KillerMemestarX','100%. Gasol’s ability to shut down Embiid is unmatched before, at the time, or since. With how close that series was, there’s no way we could’ve won it without him.','Raptors',52,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.5423,0.169,0.732,0.099),
	 ('2024-02-01','College_Prestige','Tbf Tatum isn''t going to move from that position, but Luka can.','Warriors',52,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0,0,1,0),
	 ('2024-02-01','MrPangus','Ant: Call da fouls

Refs: We were sleeping','Raptors',52,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0,0,1,0),
	 ('2024-02-01','Ok_Pineapple_5700','True but that''s what your salary is for.',NULL,52,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.2263,0.213,0.787,0),
	 ('2024-02-01','Bipedal-Moose','There is substantial overlap between r/nba subscribers and SAS viewers, how else do you think his takes get upvoted to the front page all the time?',NULL,52,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.2023,0.067,0.933,0),
	 ('2024-02-01','TrickiestToast','I can’t believe we made them not do any of that','Celtics',52,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0),
	 ('2024-02-01','jocro','Yeah I think the underlying issue here is that Steph''s alternative is to run straight line to the hoop, which effectively concedes a driving lane to Beverly. The inability to make any impeding contact whatsoever coupled with the defensive three seconds rule means that structurally the game is built to give Bev points here, because you can''t rely on having a rim protector at all times in this era of spaced out ball.

On top of the difficulties this presents defensively, the easy whistle to go from driving to "shooting" and the generally increasing lean towards allowing continuation makes for nasty work, and a lot of ugly possessions.','Thunder',51,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.3818,0.107,0.78,0.112),
	 ('2024-02-01','dittonetic','He shot it in 30% quicker than any other free throw on the night','TrailBlazers',51,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0.5106,0.202,0.798,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','schmeddy99','So if you choke a ref would it be 65k? Because some of these refs need to get choked by dray','76ers',51,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.7823,0,0.724,0.276),
	 ('2024-02-01','DomincNdo','Dude couldn''t jump but holy shit his positional defense was something else. It''s like he knows where you''re going before you do and he''ll beat you to your spot and he ain''t budging once he''s there.','Raptors',51,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',-0.2263,0.117,0.769,0.114),
	 ('2024-02-01','CoachDT','In the moment it''s fine to miss it whatever. It feels like often the L2M is their way over covering tracks. It''s something I noticed where a majority of the time when someone makes a complaint about a clear no call (unless they fall to their knees like Bron) suddenly the report comes out and goes


 "Well ACKSHULLY it''s not a foul, in fact we gave your team MORE fouls during the last two minutes than the other team"','Bulls',51,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.6705,0.138,0.79,0.072),
	 ('2024-02-01','yung-bumstain','He could have been a serious talent if he just had a jumper or played in the 2000s. Had all the tools except that one in an era where PGs have to be able to shoot','Knicks',51,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0.3612,0.134,0.771,0.095),
	 ('2024-02-01','Peatedcask','KD looks soooo happy lol','Thunder',51,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.7579,0.684,0.316,0),
	 ('2024-02-01','Next-Firefighter-753','Thunder, Wolves and Nuggets are going to have some bloodbaths in the playoffs for the next few years. ','Thunder',51,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',0,0,1,0),
	 ('2024-02-01','KillingTime_ForNow','And he got fired for being inept. Do you really want the new guy coming in & making the same mistakes?','TrailBlazers',51,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',-0.6712,0.065,0.688,0.247),
	 ('2024-02-01','Alex_Sander077','National media be like:

Embiid 35 ppg: unspoken rizz.

Luka 35 ppg: sexual harassment.','Mavs',51,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.25,0.139,0.667,0.194),
	 ('2024-02-01','ohlookanotherhottake','Booker? He dropped 62 in a loss on the same night Luka drops the most efficient 60+ night in NBA history and with 73 points. Plus averaging a 50 point triple double over the weekend. I mean I get that winning contributes but at some point you gotta see someone playing miles better than anyone else on earth and throw them a bone.','Cavaliers',51,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.8247,0.159,0.816,0.025),
	 ('2024-02-01','RookieAndTheVet','That aspect of his game also didn’t develop until after the championship season. The people who say he became a worse player after Kawhi left don’t know what they’re talking about.','Raptors',50,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',-0.0516,0.085,0.824,0.091);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','everyoneneedsaherro','Kawhi said earlier this season it’s the first time he feels healthy since 2017. Not a coincidence that’s the last time he played back to backs.

He’s not load managing cause he doesn’t wanna play. He’s been load managing because he’s been injured/recovering.','NBA',50,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.743,0.161,0.814,0.026),
	 ('2024-02-01','OblivionNA','It’s not the reason but you imagine Portland wants to see Lillard win a ring. Doc isn’t so good at that lately.',NULL,50,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.9064,0.352,0.648,0),
	 ('2024-02-01','Basketball_Reference','Marc Gasol is the Grizzlies'' all-time leader in win shares:

|Rk|Player|WS|
|-:|:-|-:|
|1|Marc Gasol|77.4|
|2|Mike Conley|71.4|
|3|Pau Gasol|53.8|
|4|Zach Randolph|51.2|
|5|Shane Battier|34.9|
|6|Mike Miller|33.1|
|7|Shareef Abdur-Rahim|31.7|
|8|Rudy Gay|29.2|
|9|Tony Allen|26.3|
|10|Jaren Jackson Jr.|21.9|

Provided by [Stathead.com](https://www.sports-reference.com/sharing.html?utm_source=direct&utm_medium=Share&utm_campaign=ShareTool): [Found with Stathead. See Full Results.](https://stathead.com/tiny/8dLy3?utm_source=direct&utm_medium=Share&utm_campaign=ShareTool)
Generated 1/31/2024.

What a career for the one of the all-time great centers.','bbref',50,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.8875,0.17,0.83,0),
	 ('2024-02-01','Vallerie_09','Camara use your offseason well cause I''m excited for the Camara-Thybulle duo next yr.','Warriors',50,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.5423,0.273,0.727,0),
	 ('2024-02-01','GhengisBrawn','Doc masterclass!','Bulls',50,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0,0,1,0),
	 ('2024-02-01','Soshi101','Some of his Boston-teams were just as stacked. He coached the Lob City Clippers in their prime, then had the Kawhi-PG duo, and then went to Philly where he got to coach MVPiid and Harden/all-star Simmons. He never got to past the second round with any of these, but the Clippers made it to the Conference Finals for the first time in franchise history as soon as he left lol.','Celtics',50,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0.5719,0.051,0.949,0),
	 ('2024-02-01','not_so_bueno','It''s giving me Harden vibes. They decided Luka is not a winner and that''s that.','Rockets',50,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.171,0.137,0.687,0.176),
	 ('2024-02-01','WIN011','Dame still a Blazer at heart','Bucks',50,'https://www.reddit.com/r/nba/comments/1ag3pwx/damian_lillard_loses_in_his_return_to_portland/',0,0,1,0),
	 ('2024-02-01','EvanTurningTheCorner','You''re welcome, Josh Hart','TrailBlazers',50,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.4588,0.5,0.5,0),
	 ('2024-02-01','rattatatouille','"They picked Dyson Daniels over me" energy','Spurs',50,'https://www.reddit.com/r/nba/comments/1afym20/highlight_jeremy_sochan_pulls_out_the_reverse/',0.2732,0.259,0.741,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','AFonziScheme','I really can''t think of anything worse as a symbol than a skull...','Mavs',50,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.4767,0,0.744,0.256),
	 ('2024-02-01','DocTheYounger','My fantasy scenario is that the benefiting player calls them out.

Like now SGA tweets backing up Ant saying he did in fact foul the shit out of him','Celtics',49,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.765,0.226,0.774,0),
	 ('2024-02-01','Biglundtry','Lol Portland puttin in work lately','NBA',49,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.4215,0.359,0.641,0),
	 ('2024-02-01','dpatel211','You could just say they’re former teammates in case people somehow forgot but yeah that works, too.','Rockets',49,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.4215,0.149,0.851,0),
	 ('2024-02-01','veryoondoww','Jpegawwwfia 🥺','TrailBlazers',49,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0,0,1,0),
	 ('2024-02-01','The_Taskmaker','Agreed and they''re acting like it''s unreasonable for Embiid to have the competitive desire to push himself through injury and stick the middle finger in the collective faces of his doubters. He shouldn''t receive any flack for playing last night; this is 100% on the medical staff or whomever is in charge of clearing players.','Nuggets',49,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.5719,0.169,0.751,0.08),
	 ('2024-02-01','SirFigsAlot','And that''s honestly true. I was able to go to MAYBE 1 cavs game in a season and if I got there and lebron was sitting I''d be devastated. Luckily he''s a dawg but these other soft ass players don''t give a about the fans','Cavaliers',49,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.4939,0.128,0.719,0.153),
	 ('2024-02-01','CrateBagSoup','Always stay in front of the circle jerk or the jerk circles you','Pacers',49,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.5859,0,0.696,0.304),
	 ('2024-02-01','ColdWarWarrior','Doc Rivers should not be let within 500 feet, of any NBA team.','Celtics',49,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0,0,1,0),
	 ('2024-02-01','Mr_E_Nigma_Solver','I was the club.','TampaRaptors',48,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','sorendiz','having the person you want shooting do the inbounding is not at all uncommon if there''s not literally <1 second or something.. the idea is to inbound and immediately get the ball back to the inbounder as they run in and look for their shot, ideally avoiding a foul. having giannis inbound and look for dame just means nobody will bother covering the inbound, they''ll just send that guy over to double dame because who else are you more worried about that pass going to? 


Now that said it was still done stupidly because Giannis is the last person you should be trying to use as the recipient of the inbounds pass when trying to do this. You want to hit your next best shooter/FT guy as insurance, not Mr. 10 Seconds','Rockets',48,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',-0.1761,0.067,0.861,0.072),
	 ('2024-02-01','Original_Trick_8552','Not just him, people in this sub were saying that too.','Celtics',48,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0,0,1,0),
	 ('2024-02-01','lalakingmalibog','Polish God','Mavs',48,'https://www.reddit.com/r/nba/comments/1afym20/highlight_jeremy_sochan_pulls_out_the_reverse/',0.2732,0.677,0.323,0),
	 ('2024-02-01','notaninterestinguser','He''s honestly my favorite up-and-comer not on our team. I know I''m going to fucking hate him in the future.','TrailBlazers',48,'https://www.reddit.com/r/nba/comments/1afym20/highlight_jeremy_sochan_pulls_out_the_reverse/',0.2516,0.231,0.616,0.154),
	 ('2024-02-01','justsomeguy254','The ref account responded to him. He didn''t go at them initially.

They got butthurt that he pointed out that it''s no fun to watch guys dribble sideways into a defender and throw their arms up.','TrailBlazers',48,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.3612,0.121,0.823,0.057),
	 ('2024-02-01','stevemoveyafeet','Sixers wishy-washiness and lack of consistency in the way they decide to hold players out or not were his downfall, totally agree. ',NULL,48,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.1263,0.111,0.797,0.092),
	 ('2024-02-01','Mindless_Bad_1591','Why he not playing tonite 😢','Timberwolves',48,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.1511,0,0.715,0.285),
	 ('2024-02-01','jeric13xd','Sixers org has zero accountability 🤌🏽','Bulls',48,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0),
	 ('2024-02-01','Guppster64','If my grandmother had wheels she’s be a bike',NULL,48,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0,0,1,0),
	 ('2024-02-01','jabronified','"conduct detrimental" is a catch all, can fine people for anything',NULL,47,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',0.2023,0.167,0.833,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','liluzigoatt','get used to this team making the same dumb mistakes over and over. doc river experience','76ers',47,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',-0.7003,0,0.707,0.293),
	 ('2024-02-01','Disastrous_Bluejay57','Call a foul lol','Nuggets',47,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',0.4215,0.583,0.417,0),
	 ('2024-02-01','hdpr92','Those numbers don''t even surprise me.  Yeah it''s a hot streak but this is Kawhi.  One of the greatest players of all time if we''re being honest, only limited by his ability to stay healthy.

If Kawhi was as healthy as KD/Steph/Giannis for his career we''d debate about who was the greater player.  Does anyone think Kawhi would get swept in the playoffs?

People get fooled by the regular season every year, when it doesn''t mean much.  16 game players are what matters.  Jimmy Butler is like the Walmart version of Kawhi and even he is a beast in the playoffs tbh.',NULL,47,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.9732,0.237,0.706,0.057),
	 ('2024-02-01','qotsabama','Yeah it’s not great. A lot of it was because our own player landed badly on his ankle, but now he’s got this pinkie injury or thumb can’t remember and it’s taken him out like the last two weeks of basketball. This team isn’t nearly deep enough to survive him not playing','Mavs',47,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.604,0.081,0.755,0.164),
	 ('2024-02-01','VectorViper','Absolutely, Lillard''s impact goes beyond the court. Players like him become part of a city''s identity; his dedication to Portland was always more than just basketball.',NULL,47,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.3612,0.094,0.906,0),
	 ('2024-02-01','jswagbo','Honestly heads up play by the blazers and Grant to foul there. 

I don’t think I’ve seen that foul happen in a game before. 

But yeah Giannis shouldn’t have been in the game. Even if Lillard wasn’t inbounding I’d probably double him on the inbound with Giannis’ man and make Giannis dribble into a game tying 3.',NULL,47,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0.7391,0.142,0.858,0),
	 ('2024-02-01','borb--','i said y''all could get to 30 i still believe','Raptors',47,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0,0,1,0),
	 ('2024-02-01','Padulsky21','I can’t stand watching this dude take FTs 😭😭😭','Nets',47,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0,0,1,0),
	 ('2024-02-01','WhenItsHalfPastFive','how does Nurkic have 25 and 9, wtf going on with the Nets defense','Warriors',47,'https://www.reddit.com/r/nba/comments/1ag192x/kd_with_some_friendly_trash_talk_to_his_friend/',-0.5106,0.087,0.694,0.22),
	 ('2024-02-01','rjcarr','The whole thing seems pretty draconian.  I get not being able to berate the refs during the game, this isn''t allowed, and techs are handed out pretty quickly (too quickly in a lot of cases).

But you can''t criticize the refs in a post game?  Really?  Ever? Seems pretty heavy handed.  Minimally they should be allowed to call out specific plays and explain why it was a bad call.','SuperSonics',47,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.8208,0.183,0.756,0.061);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','notaninterestinguser','Bc they don''t have camera in the nosebleeds lol. The bottom ring is always pretty subdued at Moda, lots of older people. 


The second level is way rowdier. ','TrailBlazers',47,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.7184,0.188,0.812,0),
	 ('2024-02-01','Powerglove2000','"We''ve investigated ourselves and have found that we have done nothing wrong" - NBA Refs','Raptors',47,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.3724,0.164,0.836,0),
	 ('2024-02-01','Mekdjrnebs','I’m beginning to believe most of Ben’s problems (mental/physical) were negatively impacted by the Sixers organization lmao',NULL,47,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.235,0.178,0.686,0.136),
	 ('2024-02-01','helix400','These kinds of plays were my favorite part of those Utah Jazz teams.','Jazz',46,'https://www.reddit.com/r/nba/comments/1afzqhm/highlight_rudy_gobert_makes_it_difficult_for/',0.6124,0.312,0.688,0),
	 ('2024-02-01','Micome','"The world was screaming in his ear" lmaoooooooo','TrailBlazers',46,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.3818,0,0.729,0.271),
	 ('2024-02-01','Sim888','https://i.imgur.com/kKyViQ1.jpg','Bulls',46,'https://www.reddit.com/r/nba/comments/1ag192x/kd_with_some_friendly_trash_talk_to_his_friend/',0,0,1,0),
	 ('2024-02-01','raftguide','Yeah, there are plans to have all four of those names in our rafters.

... well, actually a [framed vinyl record](https://www.commercialappeal.com/gcdn/presto/2021/12/12/PMCA/f100cf06-0f72-45a3-bacb-50fd3c9e2905-Rockets_30.jpg).
*shame we felt the need to be so different about this detail.*','Grizzlies',46,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.5106,0.125,0.875,0),
	 ('2024-02-01','gaycommunistnbamod','Doc working miracles over there already',NULL,46,'https://www.reddit.com/r/nba/comments/1ag3pwx/damian_lillard_loses_in_his_return_to_portland/',0,0,1,0),
	 ('2024-02-01','Dudewheresmyescoot','Besides football',NULL,46,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0,0,1,0),
	 ('2024-02-01','taygads','I think what a lot of people are missing here is that yes the NBA refs are given the rules by which to officiate the games by, but Monty McCutchen and his staff are in charge of teaching and overseeing **the interpretation** of those rules. So while they cannot create and dispel with rules as they choose, they absolutely do have control over how they interpret and enforce them. Interpreting the rule in the way they have been whereby an offensive player gets rewarded for being the one that initiates contact is the problem with these calls in the league today. If the defender initiates it then perfectly acceptable call and it makes complete sense for the offensive player to be rewarded with 2 FTs but the offensive player initiating it should not be rewarded, which is what Russillo is saying here about needing to evolve (as in adjust how rules are being interpreted and enforced if/when they see players exploiting the rule in ways that weren’t intended) instead of caring more about protecting their interpretations of said rules.',NULL,46,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.8008,0.138,0.754,0.109);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','joef_3','I was a little dubious of the Porzingis deal but honestly he’s been a great fit.','Celtics',46,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.9231,0.549,0.383,0.068),
	 ('2024-02-01','yung-bumstain','Also you usually do stuff like that in the offseason or around days off, not the day before a game when you need to review schemes','Knicks',46,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0.3612,0.094,0.906,0),
	 ('2024-02-01','MrBuckBuck','He probably has ClippersVision installed into his hardware somewhere.','Wizards',46,'https://www.reddit.com/r/nba/comments/1afz9za/highlight_russell_westbrook_hits_kawhi_with_the/',0,0,1,0),
	 ('2024-02-01','BurnedInTheBarn','White, Kristaps, and Holiday are all him. Brogdon, who we used to get Holiday was also him. The salary filler bench depth for KP was also all players acquired under him.','Celtics',46,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.6597,0.157,0.843,0),
	 ('2024-02-01','EvanTurningTheCorner','Can''t give the competition too much tape before the Finals','TrailBlazers',46,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0,0,1,0),
	 ('2024-02-01','beybladethrowaway','how do you turn a post about russ to lebron.',NULL,46,'https://www.reddit.com/r/nba/comments/1afz9za/highlight_russell_westbrook_hits_kawhi_with_the/',0,0,1,0),
	 ('2024-02-01','ahrzal','I don’t know shit about fuck','Bucks',46,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',-0.7964,0,0.297,0.703),
	 ('2024-02-01','JAhoops','Stephen A doesn’t even watch basketball',NULL,46,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0,0,1,0),
	 ('2024-02-01','Im__Ron__Burgundy','*limping ^sorry','Celtics',45,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0),
	 ('2024-02-01','d1g1tal','It’s not 69% but it’s close to “nice”','Clippers',45,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','tacomonday12','He''s acting like he was guaranteed an All-NBA spot if he played over 65 games. He''s been great so far, but we have almost half a season left and it''s positionless this time. Premature celebrations all around.','NBA',45,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.6124,0.154,0.846,0),
	 ('2024-02-01','w0nderbrad','I mean… passing up a wide open layup for a pass that’s much harder… lol','Lakers',45,'https://www.reddit.com/r/nba/comments/1afz9za/highlight_russell_westbrook_hits_kawhi_with_the/',0.4215,0.203,0.797,0),
	 ('2024-02-01','junkit33','They’re deflecting from their incompetent medical staff and/or a front office that is allowing things they shouldn’t be.',NULL,45,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.4767,0,0.838,0.162),
	 ('2024-02-01','maethlin','I really do wonder why they do this... he was pretty clear he didn''t want one.','Warriors',45,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.6786,0.305,0.631,0.064),
	 ('2024-02-01','everyoneneedsaherro','What’s more likely, Kawhi has been dealing with his knee injuries for years and has been load managing it to keep the injury at bay and even then has re-injured his knee with critical injuries several times despite his best efforts? Or he’s taking games off because he’s soft?

Embarrassing this hate is coming from a Raptors flair. Ungrateful.','NBA',45,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.9572,0,0.734,0.266),
	 ('2024-02-01','Portland','We love our Blazers, and Dame is the GBOAT!','TrailBlazers',45,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.6696,0.36,0.64,0),
	 ('2024-02-01','anesthesiologist2','Bad decisions by the Sixers here, but it’s amazing how many of you are playing both sides. I thought it was a fake injury and he was ducking?','Warriors',45,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.4019,0.192,0.545,0.262),
	 ('2024-02-01','Parking-Bat9498','Easily a case of suffering from success. He’s been a walking 28/8/8 since year two so this is just expected. Which is fucked up. He’s playing good defense on a really high usage with Dallas having horrible injury luck all year.','Mavs',45,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.128,0.268,0.49,0.242),
	 ('2024-02-01','SuckMyLonzoBalls','It really is insane that thread was wild','Clippers',45,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.4549,0,0.702,0.298),
	 ('2024-02-01','KillingTime_ForNow','I swear if he gets any sort of an offensive repertoire Camara could be the future wing we''ve been looking for since forever.','TrailBlazers',45,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',-0.5413,0,0.817,0.183);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','OsuLost31to0','Kawhi is one of the best players to watch when he’s fully healthy - glad he’s having the season he is having','Cavaliers',45,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.8878,0.368,0.632,0),
	 ('2024-02-01','K1ngCrimsn','Giving up 2 offensive rebounds in the clutch to one of the worst rebounding teams',NULL,45,'https://www.reddit.com/r/nba/comments/1ag14vv/highlight_holmgren_hits_daggers_triple_with_vs/',-0.6908,0.117,0.537,0.346),
	 ('2024-02-01','EgoVegito','r/nba Put up the mission accomplished banner',NULL,45,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.4404,0.326,0.674,0),
	 ('2024-02-01','ProsecUsig','For Pop it was unintentional','Mavs',45,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0,0,1,0),
	 ('2024-02-01','NotManyBuses','To be fair, you can’t spell his last name','ChaHornets',45,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.3182,0.223,0.777,0),
	 ('2024-02-01','MELOPOSTMOVES','Why are you comparing using Al Qaeda as a team building case study to using an MLK video',NULL,44,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0,0,1,0),
	 ('2024-02-01','chizburger999','> Thats my mvp

You wanted him traded a month ago. You are one of those saying he was washed lol','Clippers',44,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.4215,0.135,0.865,0),
	 ('2024-02-01','HopelessArgonaut','It''s an extreme example, but the logic has merit. Someone like Mikal should be rewarded for showing up night in and night out. As much as everyone likes to say availability is the best ability, there should be some kind of incentive for it. Plus, the fans pay to see the stars play. I didn''t pay $100+ per ticket to see a starting backcourt of Jaden Hardy and Dante Exum, I paid for Luka/Kyrie, and the cost isn''t refunded to me if Luka/Kyrie don''t play.

I agree 75 is too high, because if someone rolls their ankle or pulls a muscle, there goes their MVP/All-NBA shot, but 65 does also seem too low. 70 to me seems like the best middle ground.','Mavs',44,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.9911,0.293,0.652,0.055),
	 ('2024-02-01','Wuffy_RS','Stephen A blamed the Hawks defense and said nothing else','Lakers',44,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.3818,0.129,0.603,0.267),
	 ('2024-02-01','JevvyMedia','It''s also stupid to blame the media for someone falling into Embiid''s knee, as if this wasn''t a freak incident that happens in games all the time.','Raptors',44,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.6116,0.076,0.692,0.233);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','WestleyThe','I wish he played with someone like Chris Paul in his prime. Literally just let him play defense and catch lobs and he’s great','SuperSonics',44,'https://www.reddit.com/r/nba/comments/1afzqhm/highlight_rudy_gobert_makes_it_difficult_for/',0.9274,0.479,0.521,0),
	 ('2024-02-01','allaboutthatpace','That''s a crazy shot off the wrong foot. Ant is an elite scorer with a deep bag.','TrailBlazers',44,'https://www.reddit.com/r/nba/comments/1ag3nvh/highlight_anfernee_simons_with_the_tough_runner/',-0.6705,0,0.703,0.297),
	 ('2024-02-01','SpicyJimbo77','*nawl','Celtics',44,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0,0,1,0),
	 ('2024-02-01','Hydrauxine','the crowd was COUNTING','Nuggets',44,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0,0,1,0),
	 ('2024-02-01','floatermuse','I mean didn’t the Mavs have like only 2 or 3 starters playing lol 

 Now if you want to say that Kyrie was too risky a bet because he ALWAYS misses a ton of time I get it but at the same time his baggage was the only reason they didn’t have to give up more for him in the first place ',NULL,44,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.3291,0.105,0.847,0.048),
	 ('2024-02-01','LeakyBrainMatter','As the current sufferer of a torn pcl that doesn''t have the time or money for surgery I wish this was the case. I''m fine most of the time until I step wrong and my knee gives out or I sit too long with my leg in the wrong position and I''m in excruciating pain. Or worst of all, because I hoop on a regular, I make a cut and my knee completely gives and I can''t walk without assistance for a week and can''t get comfortable because I''m in pain. Last part happened to me a couple months ago and I just got back in the gym this last weekend. It fucking sucks even though it can''t be seen.

Now amplify all that shit for a professional athlete who has to compete with other professional athletes at that level. I played in college so I''m normally one of the most skilled players in the gym. Aside from the pain I can afford to be a step slow or just shoot jumpers because I can''t drive right now. I can take plays off on D. I''m not playing against hyper athletic best in the world players where I have to go all out all the time. Also I''m not getting paid for it and they are.

I feel for Kawhi, AD, and all the other guys that deal with this shit. For Kawhi to come back and play at this level is amazing. People seem to think you''re back to 100% after injuries and surgeries but the facts are you''ll never be 100% after that. The parts that were originally there are compromised and sometimes not even there anymore.','Bulls',43,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',-0.9324,0.047,0.839,0.114),
	 ('2024-02-01','Vallerie_09','Got 2 coaches fired in 6 months','Warriors',43,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',-0.5574,0,0.526,0.474),
	 ('2024-02-01','StarryScans','Seth is definitely Wayne','JPN',43,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.4019,0.474,0.526,0),
	 ('2024-02-01','37sms','''15 Marc was a top 6-8 player in the league. If he played for nearly any other team he would be remembered much better. Also didn''t help that he was unselfish to a fault and cost himself stats in the process.','Grizzlies',43,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.2828,0.154,0.738,0.108),
	 ('2024-02-01','abrnst','Legal guarding position is stupid. Should do away with it.','Rockets',43,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.4404,0.116,0.62,0.264);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','tacomonday12','These are players who are already making the max. If they wanna risk injury to turn their $200 million contract into $270 million contract, the responsibility of whatever happens falls on them and them alone. Same goes for accolades. You injury-prone? Tough luck, you were born a physical freak enough to make the NBA and become a star. I genuinely don''t give a fuck if you''re unable to accept your limitations and wanna risk breaking your legs because you wanna rack up awards like LeBron or Kobe. You just don''t have the talent, buddy. Like I don''t have the talent to even make the Guatemalan league.','NBA',43,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',0.0992,0.135,0.716,0.149),
	 ('2024-02-01','Mindless_Bad_1591','He''ll probably score more points but I can see wemby averaging 30/12/5/2/4 in a couple years.

Like the kid is on a minutes restriction in his rookie year and is putting up 20/10/3/1/3. That''s not right lol.','Timberwolves',43,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.3395,0.081,0.777,0.142),
	 ('2024-02-01','LakersFan15','At least it’s better than mark jackson who uses the more evangelical style.','Lakers',43,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0.4404,0.195,0.805,0),
	 ('2024-02-01','OUEngineer17','As a fan of both teams, this one was fun. Good defense by both teams, and great highlights by Chet and AG.','Nuggets',43,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',0.9201,0.468,0.532,0),
	 ('2024-02-01','LeGrandeK','He never did get Effie Payton “right”.',NULL,43,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0,0,1,0),
	 ('2024-02-01','zippy_the_cat','He''s one of those rare guys who actually *wants* to take that shot. Presti oughta be hitting his knees every night to thank god and Orlando for his good fortune.','Lakers',43,'https://www.reddit.com/r/nba/comments/1ag14vv/highlight_holmgren_hits_daggers_triple_with_vs/',0.7579,0.217,0.783,0),
	 ('2024-02-01','dwadwda','thats genuinely mindbreaking wtf lmao','Raptors',43,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.0258,0.364,0.28,0.355),
	 ('2024-02-01','syntacticts','Then they will get the "employee of the day" award.',NULL,43,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.5423,0.28,0.72,0),
	 ('2024-02-01','Losalou52','They are only 3.5 games behind the sixers….','TrailBlazers',43,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0,0,1,0),
	 ('2024-02-01','HooliganBeav','Look, we squandered most of Dane’s time here with bad roster moves.  But at least we never made him play for Doc Rivers.  Jesus.','TrailBlazers',42,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',-0.5864,0,0.821,0.179);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','Thermicthermos','Because they''ve convinced themselves that social media presence is so important even though they have yet to come up woth a way to capitalize on that.','Mavs',42,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.6207,0.181,0.819,0),
	 ('2024-02-01','pjtheMillwrong','The media voted 5 players below the current threshold to all NBA last year','Raptors',42,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0,0,1,0),
	 ('2024-02-01','TerryPressedMe','Me too, and I’m not even a Raptors fan, but the whole energy behind that run was infectious, especially after the tough playoff losses that preceded 2019. Kawhi and the Raptors proved a lot of people wrong that year. As a neutral fan, it was pretty epic to see.',NULL,42,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',-0.7022,0.116,0.653,0.231),
	 ('2024-02-01','notafan1','Tbf he was making all his three''s prior to that so I don''t blame him.','Timberwolves',42,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0.3214,0.151,0.849,0),
	 ('2024-02-01','blocking-io','> Suddenly completely healed


I wouldn''t say 7 years of rehabbing is "sudden"


Also, he''s got his extension already, he''s already set for the next 3 years',NULL,42,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0,0,1,0),
	 ('2024-02-01','-_TabulaeErunt_-','Any bullshit that hes a quitter was sent to the bin in ''19. People say that the warriors lost because they were injured in 2019 don''t remember that the raps had to go through the 4th and 3rd best teams in the playoffs while the dubs ran through a weak WC, raps had waaay more load on their legs. The guy was dunking on mvp giannis and then hobbling to come back to defend, he was definitely taking his body to the limit.',NULL,42,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',-0.5859,0.074,0.801,0.125),
	 ('2024-02-01','ballaballaaa','It''s a performance bonus, not his normal pay','Lakers',42,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.5853,0.49,0.51,0),
	 ('2024-02-01','AlligatorPoontang','Thibs tried to do it for yogurt years ago but Deandre Jordan turned into a sharpshooter','Timberwolves',42,'https://www.reddit.com/r/nba/comments/1ag2hl8/highlight_target_center_goes_crazy_for_free/',0,0,1,0),
	 ('2024-02-01','RookieAndTheVet','Selfishly, I was disappointed he didn’t get the mic, but it was definitely for the best.','Raptors',42,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.8225,0.388,0.456,0.156),
	 ('2024-02-01','cromulu5','This video? https://www.youtube.com/watch?v=I6rjp3Arv-o','Timberwolves',42,'https://www.reddit.com/r/nba/comments/1ag2hl8/highlight_target_center_goes_crazy_for_free/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','raftguide','Yeah, he was [playing over in spain and having a blast from the looks of things](https://www.youtube.com/watch?v=VQJ6tSg9_k4).','Grizzlies',41,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.296,0.136,0.864,0),
	 ('2024-02-01','Torkzilla','Yeah, the scoring title should be points scored for the season not points per game.

Similar to the Golden Boot for most goals scored in top leagues of Europe.','Pistons',41,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.4588,0.129,0.871,0),
	 ('2024-02-01','Basketball_Reference','That definitely stood out, too. He''s about to turn 29 ...','bbref',41,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.4019,0.213,0.787,0),
	 ('2024-02-01','TheRealFakeDoors503','Brogdon really is the glue guy that allows the Blazers to look semi-competent, without him we fall apart.

Hopefully his fantastic play attracts some serious bidders at the trade deadline.','TrailBlazers',41,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.8779,0.302,0.663,0.034),
	 ('2024-02-01','NBAccount','That would remove one of the Ref''s primary means to make money: shaving points.','Warriors',41,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0,0,1,0),
	 ('2024-02-01','LeGrandeK','You’re right. I was confusing my draft bust guard Knick reclamation projects.',NULL,41,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',-0.2263,0,0.84,0.16),
	 ('2024-02-01','RubMyGooshSilly','Also doesn’t help that Luka was way too fucking good way too fucking quick and we had no time to build naturally through the draft. Front office felt like “time is now” on his rookie contract and swung for the fence with KP.

Hindsight is 20/20, but our draft picks would have been mostly mid to late 1st round even if we kept them','Mavs',41,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.476,0.085,0.892,0.024),
	 ('2024-02-01','pedja13','He is too big and too strong,and his two man game with KD is great',NULL,41,'https://www.reddit.com/r/nba/comments/1ag192x/kd_with_some_friendly_trash_talk_to_his_friend/',0.6249,0.227,0.773,0),
	 ('2024-02-01','MisterTukul','This works best when you watch it from the start, listening to those laughs brewing in the background. Lmao','Nuggets',41,'https://www.reddit.com/r/nba/comments/1afy0gl/nehm_damian_lillard_on_walking_into_the_visitors/',0.9062,0.414,0.586,0),
	 ('2024-02-01','TheCalvinator','I think pop knew we weren''t contenders, so why not let people play roles they would never play om a contending team and work to develop skills in live games they otherwise would not get the opportunity to develop. Those games appear to have paid dividends as sochan''s passing from the 4 has looked improved since he moved back.','Spurs',41,'https://www.reddit.com/r/nba/comments/1afym20/highlight_jeremy_sochan_pulls_out_the_reverse/',-0.3191,0.05,0.845,0.104);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','thedrcubed','We got blasted for firing him too. Even LeBron chimed in. He was an absolutely terrible coach','Grizzlies',41,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',-0.6997,0,0.721,0.279),
	 ('2024-02-01','MerkDoctor','> gambling is a major revenue stream.

Maybe it''s not a surprise the league''s integrity is in question.',NULL,41,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.1989,0.149,0.747,0.104),
	 ('2024-02-01','lasagna_for_life','Always follow the money, they aren’t even trying to hide it anymore lol','Raptors',41,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.2732,0.181,0.71,0.11),
	 ('2024-02-01','panman42','There other two Embiid games against the Raptors that year: 5pts and 10pts. And Embiid was a 28ppg scorer that year. Gasol was different.',NULL,40,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0,0,1,0),
	 ('2024-02-01','Tackis','Holy fuck','Spurs',40,'https://www.reddit.com/r/nba/comments/1afym20/highlight_jeremy_sochan_pulls_out_the_reverse/',-0.5423,0,0.222,0.778),
	 ('2024-02-01','SmokeyBare','The opposite of fair weather fans is Portland fans','Spurs',40,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.3182,0.223,0.777,0),
	 ('2024-02-01','VeniceRapture','What if we remove the 65 game limit rule, but for every game you don''t play you get zeroes across the board','Spurs',40,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',-0.3724,0,0.892,0.108),
	 ('2024-02-01','driatic','Stephen A is also known for bringing sports discussions into the toilet.

Yes, he used to be and can sometimes be a good journalist who has well thought out takes.

But most of his takes are meant to draw attention, anger.

All this to say even a broken clock is right twice a day.','Wizards',40,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.7814,0.09,0.756,0.154),
	 ('2024-02-01','jaytee158','Even if he doesn''t, he isn''t entirely wrong about this',NULL,40,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.4158,0.235,0.765,0),
	 ('2024-02-01','T_025','Bizzaro JR smith','Lakers',40,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','MMO4life','Fun guy','Clippers',40,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.5106,0.767,0.233,0),
	 ('2024-02-01','GarriganGate','If Kyrie or Harden would’ve had enough time to get into playing shape, they absolutely would’ve been ','Raptors',39,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.2023,0.101,0.899,0),
	 ('2024-02-01','Hellinar','What’s your humor setting, Kawhi?',NULL,39,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.2732,0.344,0.656,0),
	 ('2024-02-01','eunauche','Yeah, these responses are bullshit. Man was getting generational slander across multiple platforms, but it’s not supposed to affect him. That’s a trash ass notion','Nuggets',39,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.7615,0.054,0.706,0.24),
	 ('2024-02-01','swhos','Never tell him the odds.','Clippers',39,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0,0,1,0),
	 ('2024-02-01','Dat_Boi_John','Luka isn''t even that big a defensive liability anymore, imo he is a neutral to slightly plus defender. His low block defense is actually very good statistically and his opponent fg% is very low for a guard, although the latter is skewed because his assignment is usually the worst offensive player to conserve energy.

Also I''m pretty sure Tatum''s defense would take a significant hit if he had to play the most minutes per game in the league and have one of the highest usage rates.

If you take into account Luka''s scoring volume and efficiency (he is the best shooter and 3pt shooter in the league this year) as well as his assists and created open shots (our shooters are ASS) he is quite a bit better than Tatum offensively.','Mavs',39,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.8553,0.216,0.658,0.125),
	 ('2024-02-01','iamthegame13','They should do a firing ceremony before every game just to be sure. Tell Griffin he doesn''t get his salary if he doesnt attend','Raptors',39,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',-0.0258,0.089,0.817,0.093),
	 ('2024-02-01','SenorMcNuggets','In terms of skill and scheme complexity, it is in a great state. But officiating is something else entirely. Sadly, the latter overshadows the former because the refs think they’re the stars.','Cavaliers',39,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.3797,0.071,0.813,0.116),
	 ('2024-02-01','IncaseAce','Life of a basketball fan, truly','Thunder',39,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',0.6369,0.634,0.366,0),
	 ('2024-02-01','IncaseAce','[Us watching those 3 games](https://www.control4.com/files/large/c0c188ca6447469d89939780e62cbedd.jpg)','Thunder',39,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','Zoratth','They could lose the rest of their games this season and probably still make the play-in. The 10-15 seeds are all either tanking or just terrible','Clippers',39,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',-0.7003,0,0.805,0.195),
	 ('2024-02-01','rattatatouille','> Probably better to not have media awards tied to contract incentives, but that’s something the NBPA should be fighting against

I think that''s the issue here. Elite players missing out on postseason awards because they''re hurt is one thing, elite players getting shortchanged on contracts because they got hurt (and nobody wants to get hurt) is another.','Spurs',39,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',-0.9559,0.05,0.668,0.281),
	 ('2024-02-01','Jwoods4117','Sure but that’s why it’s set at 79% anyway. Plus we’re talking about being eligible for awards within the top 0.001%, not them being fired or anything. It’s not the same sure, but I think the point is that their job has to hold them to some sort of standard and is way more lax than most as it is.',NULL,39,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',0.8516,0.172,0.792,0.036),
	 ('2024-02-01','elliott9_oward5','Not being assigned to a playoff game, oh the horror. They still get paid and benefits. It’s a joke. They get an early vacation to be bad.','76ers',39,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.5267,0.145,0.636,0.218),
	 ('2024-02-01','drhoops15','Haliburton already signed an extension, plus even if he hadn''t, he''d still be a RFA.','Hawks',39,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0,0,1,0),
	 ('2024-02-01','SinCos_x','so dame you comin back?','TrailBlazers',39,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0,0,1,0),
	 ('2024-02-01','poopstainmclean','Chauncey blundered late too...ant got trapped in the backcourt and fumbled it away when we had 2 timeouts with 30 seconds left','TrailBlazers',38,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',-0.5267,0,0.855,0.145),
	 ('2024-02-01','OmniSzron','Bruh, it''s just a 20 sec. video. It''s not like we''re retiring the jersey of the guy who shit on us, left us and then bullied us to retire it in a rap song.','Nets',38,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',-0.8693,0,0.747,0.253),
	 ('2024-02-01','rsvchamp55','That corny copypasta ever since Kat and Wiggins days. Yall been through a lot lmao.','Thunder',38,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',0.5994,0.231,0.769,0),
	 ('2024-02-01','StarryScans','Sorry, him and three-peat champion Patrick McCaw','JPN',38,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.5574,0.382,0.49,0.127);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','edwardhyeung','FEAR THE REATH','Nuggets',38,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',-0.4939,0,0.385,0.615),
	 ('2024-02-01','wintermelonsilk','Part of the complaint was that he was pulled for an injury 10 minutes before the game without being listed as injured.','Wizards',38,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.7717,0,0.712,0.288),
	 ('2024-02-01','Csalbertcs','How could you forget NBA champion Jeremy Lin!',NULL,38,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.5093,0.347,0.496,0.157),
	 ('2024-02-01','iamtheshadowking','It is.','TrailBlazers',38,'https://www.reddit.com/r/nba/comments/1afy0gl/nehm_damian_lillard_on_walking_into_the_visitors/',0,0,1,0),
	 ('2024-02-01','po2gdHaeKaYk','There is. You’re right. But I don’t think most people care about the distinction. Russillo is criticising the ref for defending an obviously flawed rule.

It’s not super well argued, but I think it achieves the point that most people agree with.

He’s also criticising the vacuousness of the response, which I also agree. The referee is saying that the call is correct given the rule. But the discussion is implicitly about the correctness of the rule itself.

Either the rule needs to be changed or codified, and/or the refs need to re-interpret the rule. Viewers don’t really care which one it is, as long as it is done consistently.',NULL,38,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.7842,0.148,0.748,0.103),
	 ('2024-02-01','imianha','As a fellow spaniard it hurts seeing both Gasol brothers retiring, and Ricky as well... We only have Santi Aldama now','Mavs',38,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',-0.4767,0,0.86,0.14),
	 ('2024-02-01','BobLobLaw_Law2','Ultimately him not going to the Heat rebuilt a lot of bridges. But the Heat got Rozier, who''s awesome right now, so everybody wins........',NULL,38,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.7684,0.204,0.796,0),
	 ('2024-02-01','iMaticz7','Very mid season from him, holy shit',NULL,38,'https://www.reddit.com/r/nba/comments/1ag3pwx/damian_lillard_loses_in_his_return_to_portland/',-0.5574,0,0.625,0.375),
	 ('2024-02-01','turkmileymileyturk','Because the fan experience and the marketing behind it is more important than KD in his feelings.','Thunder',38,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.5256,0.227,0.773,0),
	 ('2024-02-01','jwil06','I’ve watched so many players drive this year and completely slam on their brakes with a trailing defender to go to the line. I get it’s a foul but holy fuck it’s just a bad viewing experience. It sucks.','Magic',38,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.9382,0.026,0.654,0.32);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','beatnickk','He was unplayable and benched by Rick in 21 playoffs, and then of course was awesome in 22 and we went to the WCF, and then he left. What part wasn’t true of what he said?','Mavs',38,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.7845,0.169,0.831,0),
	 ('2024-02-01','therealunbread','I love Blazers fans','Bucks',38,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.6369,0.677,0.323,0),
	 ('2024-02-01','GillbergsAdvocate','>I''m not talking about anybody whos had legitimate injuries

Proceeds to name 4 of the most injury-prone players in the league','Warriors',38,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0,0,1,0),
	 ('2024-02-01','OKCBaller035913','No it should be seven the Detroit game counts twice','Thunder',38,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',-0.296,0,0.804,0.196),
	 ('2024-02-01','ListenToWhatImSayin','NBA players have an entire off-season where they aren''t required to play or practice, which is all of July, August and September before returning to preseason camp. That doesn''t account for most teams not playing at all in June and May, or half of April. The NBA regular season is officially 5 months and 22 days (not including roughly 3 weeks of training camp).

I''m pretty sure players get like 20 off-days per season, so that means like 1 day per week of the season, so roughly working 6 day weeks for half the year for a non playoff team. So what''s that? 150 days per year worked?

Your example of a european office worker is what 5 days a week x 52 - 30days = 230 days. That''s still 80 fewer days worked by a non-playoff player than a european office worker.

Not that this comparison is worth anything at all anyway.','Knicks',37,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.8346,0.085,0.889,0.026),
	 ('2024-02-01','MoltenPandas200','My mistake I thought you wanted the goalposts where you set them, not in a totally different spot','Bucks',37,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',-0.34,0,0.862,0.138),
	 ('2024-02-01','Substantial-Fold-592','Bracing myself for the “everybody acting tough when they up” nonsense','Suns',37,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',-0.4939,0,0.682,0.318),
	 ('2024-02-01','TomTidmarsh','100%. I can’t think of a few fan bases this wouldn’t happen with',NULL,37,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.3182,0.187,0.813,0),
	 ('2024-02-01','Ronin607','It depends on if the person that replaces Haliburton on All-NBA is also in a position to have a contract that''s affected. There will be years where someone will be eligible for the super max because someone ahead of them didn''t meet the threshold, it''ll all even out over a long enough timeframe and I doubt the money lost by the players as a whole amounts to much.',NULL,37,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',-0.128,0.056,0.851,0.092),
	 ('2024-02-01','Headlesshorsman02','GG nugget bros, good luck the rest of the season, all the best 🤝🤝','Thunder',37,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',0.9191,0.566,0.434,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','johnhenryirons','Wasn’t it Mudiay that he was gonna get “right”?','Knicks',37,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0,0,1,0),
	 ('2024-02-01','fishgoesmoo','Danny Green is a G for not letting him get the mic, but I''m still convinced he robbed us from a GOAT parade speech.','Grizzlies',37,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.5499,0.151,0.849,0),
	 ('2024-02-01','lost_in_trepidation','I once worked in an office for 2 years without realizing there were 2 large conference rooms past the supply room.','Mavs',37,'https://www.reddit.com/r/nba/comments/1afy0gl/nehm_damian_lillard_on_walking_into_the_visitors/',0,0,1,0),
	 ('2024-02-01','StuckInBronze','And that''s enough lol, still a chip.',NULL,37,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.4215,0.359,0.641,0),
	 ('2024-02-01','FaYt2021','He’s just like me fr, expect I also don’t know basketball','Nuggets',37,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.3612,0.217,0.783,0),
	 ('2024-02-01','deemerritt','I mean thats largely just due to the dynamics of cable tv and not much that Silver has actually done. If cable collapses the NFL will be fine, i am not so sure about the NBA','ChaHornets',37,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.1959,0.101,0.778,0.121),
	 ('2024-02-01','BigCountryBumgarner','[https://i.imgur.com/Ty1lfOJ.png](https://i.imgur.com/Ty1lfOJ.png)

Cap','Suns',37,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0,0,1,0),
	 ('2024-02-01','Scottsid','>.All he has to say is look at these bozos without me.

Exactly the point. How they won only a single title is a headscratcher. 3 minimum.',NULL,37,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0.5719,0.139,0.861,0),
	 ('2024-02-01','CumAssault','Bro Dame has been mid all season. He has to figure this shit out. Not sure if it''s age decline or mental or what, but he''s been a terrible trade so far','Spurs',36,'https://www.reddit.com/r/nba/comments/1ag3pwx/damian_lillard_loses_in_his_return_to_portland/',-0.805,0,0.772,0.228),
	 ('2024-02-01','Hardcover','[Link ](https://youtu.be/mejFtEY5faU?si=qeXtkCxOKy_idXFL) for the uninitiated.',NULL,36,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','Colorado_designer','Good point. Plus, last year WAS a duck, he played the games before and after the missed DEN matchup. And he missed it when people were saying that a good Jokic performance would make him the favorite again, so it was all for narrative manipulation. Played with fire','Nuggets',36,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.6808,0.228,0.621,0.151),
	 ('2024-02-01','C4242','Except you were only down two then, a foul would be stupid in that scenario.


The blazers were going to foul whoever got the ball, so why give it to Giannis.','Timberwolves',36,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',-0.5267,0,0.895,0.105),
	 ('2024-02-01','SuckMyLonzoBalls','Realistically, to have a shot

Clippers first seed

75 games played

27.5 PPG

7.5 RPG

5 APG

55/44/90 shooting splits

and he''d have to have high numbers in a lot of advanced defensive stats like deflections and loose ball pickups and continue playing at a first team all defense

He''s also average 2.2 3s a game, and 2.6 stocks a game. Doing all this on only 1.6 TOs is insane','Clippers',36,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.5106,0.156,0.775,0.069),
	 ('2024-02-01','IEatPussyLikeAPro',' Because they did the thing the didn’t want, which is being out jerked. I find this hilarious.',NULL,36,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.296,0.213,0.691,0.096),
	 ('2024-02-01','bewarethegap','119, but yeah','Thunder',36,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.4215,0.583,0.417,0),
	 ('2024-02-01','aguas_freskas','No shit, if any of us had the choice of doing less work for the same money we would do exactly that.','Spurs',36,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.7003,0,0.775,0.225),
	 ('2024-02-01','BigFatModeraterFupa','It was basically an upgrade from dinwiddie to Kyrie Irving. anyone would have to make that trade','Mavs',36,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0,0,1,0),
	 ('2024-02-01','t-homas','dame got two videos!! one for his basketball contributions and another for his charitable and community efforts','TrailBlazers',36,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',0.508,0.17,0.83,0),
	 ('2024-02-01','LoverRomeox','Shush, I am an expert on this topic.

Source: never been to an NBA game',NULL,36,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0,0,1,0),
	 ('2024-02-01','HS941317','Bucks got a washed version of Lillard lmao',NULL,36,'https://www.reddit.com/r/nba/comments/1ag3pwx/damian_lillard_loses_in_his_return_to_portland/',0.5994,0.394,0.606,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','kihraxz_king','One of these times I want the guy who committed the foul and got away with it to do the complaining.  Or at least publicly admit "Oh yeah, dude was totally right.  I dragged his arm.  Totally a foul.  I''m gonna pay his fine for him because that was bogus."

Right now, only the player/team that got screwed is saying anything.  The team that benefited from it saying something will be a whole lot harder to ignore.','Spurs',36,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',-0.2911,0.111,0.763,0.126),
	 ('2024-02-01','HoopsMcCann750','Maxey is dinged up and they are tumbling down the standings. Embiid sitting out every game isn’t the easy “do what’s best for the team” move that people are insinuating.','Pacers',36,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.7964,0.202,0.798,0),
	 ('2024-02-01','Fickle_Twist1209','Forgot to switch accounts chief','Nets',36,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0,0,1,0),
	 ('2024-02-01','RuneLite23','Because the “problem” makes them lots and lots of money *cough* gambling *cough*',NULL,36,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0,0,1,0),
	 ('2024-02-01','cuttino_mowgli','Yes that happened.','Thunder',36,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.4019,0.574,0.426,0),
	 ('2024-02-01','nam67','Absolutely.  They were planning to retire TA''s #9 but the fraud charges started circulating.  I think they are still planning to do it once everything with that situation has resolved.  Mike will definitely be in the rafters too when he retires.','Grizzlies',36,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',-0.5023,0.113,0.728,0.159),
	 ('2024-02-01','panchettaz','3rd last game of the season for both teams, coming off a b2b for both with Nuggets playing in Utah and TWolves playing against the Wizards

ESPN and NBA''s genius schedulers are about to see 22 mins of the most mid bball by the starters, then a full showcase of what Hunter Tyson and Jalen Pickett are all about',NULL,36,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',0.3818,0.061,0.939,0),
	 ('2024-02-01','CrastersSons','If only we had a guy who was an incredible rebounder','Nuggets',36,'https://www.reddit.com/r/nba/comments/1ag14vv/highlight_holmgren_hits_daggers_triple_with_vs/',0,0,1,0),
	 ('2024-02-01','rexter2k5','It''s nuts because I loved playing defense when I was a kid in rec ball. Not even from a blocking standpoint. I just loved getting into an opponent''s body and then deflecting, poking and stealing the ball. I was happiest turning the game into a track meet.

But I also could not develop a consistent jumper, so I just found joy in other things.

Edit: mini stroke','TrailBlazers',36,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.9069,0.25,0.692,0.058),
	 ('2024-02-01','stfuUzifloating','this has been a strange thing all season, he has good first half then gets benched pretty much for the rest of the game','TrailBlazers',36,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.6486,0.219,0.717,0.065);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','Hesi-Timbo','Ignore my flair, this opinion is based on my love of math and sports analytics: Scoring title is MUCH different than Golden Boot or Home Run title or total touchdowns like NFL. To be clear, scoring title doesn''t mean MVP in my eyes, availability is important for measuring that.

Let''s say you miss about 10% of the season of each. Bad luck. You''ll have to score 11.1111% more per game than the next guy to equal his total output. Let''s see what that actually equates to

**Soccer**: Haaland is scoring just about a goal per game (wayyyy above average), so let''s take that as your opponent, which would be worst case for my point. Over 38 games, if you miss 4 games, you''ll need to score 4 more goals than your average, or about 0.1 more goals per game. Your goals per game gap will be miniscule compared to Haaland, if you miss out by one it''s not a huge deal. 38/34 - 38/38 = 0.12 more goals per game.

**Baseball**: The best batter this season had 1 homerun per 3 games. If you miss 16 games, you have ~4 homeruns to catch up on throughout the season. Again, it''s not anything you can chalk up to more than luck. A few slightly foul balls, a few gusts of wind away. 54/146 - 54/162 = 0.036 more homeruns per game.

**Football**: The lower volume does screw you a bit here, but again, if you miss 2 games you have 4TDs to make up over 15 games. 34/17 - 34/15 = 0.26 more TDs per game. This one I think is a sizeable difference in football, but even still, over 15 games if you can muster 4 more instances of fortune, maybe a blown coverage, you catch up.

Now finally

**Basketball**: at 36ppg (Joel before last night), if you miss 8 games, your opponent suddenly has to score 31.6 vs your 36. 4.4 more points per game, and while it''s true that it scales again to be about 11.1111% more just like for every sport, you can''t possibly make it up in a span of good luck over 2 games. In baseball, soccer, maybe football, you could make up that small per-game difference in a 2-4 game hot streak including good luck and chances. In basketball, you would need about 6 70 pieces to make up the difference while scoring at the same rate the other nights. That''s like Wilt''s career 70 pieces, but all in one season.

The luck/hot streak/situational advantage required to make up the difference in other sports is a lot less extreme, so measuring "per game" doesn''t show a lot of significance. Golden boot is more of a fun thing than a proof of who is the best scorer, whereas in basketball you simply can''t make up the difference without being *significantly* better than the person who plays more games night in and night out because outlier games are MUCH harder to come by, and those outliers would be enormous record breaking outliers. Therefore, scoring rate, with a minimum qualification, is a much better metric for the scoring award in basketball.','76ers',35,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.9929,0.119,0.834,0.047),
	 ('2024-02-01','dumdum2727','I think you forgot the funny part of the joke',NULL,35,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.6249,0.421,0.579,0),
	 ('2024-02-01','braddeus','Heard about you and your honeyed words','Heat',35,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0),
	 ('2024-02-01','dpatel211','Ain’t shit funny… 😔','Rockets',35,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',-0.5574,0,0.357,0.643),
	 ('2024-02-01','Culinaryboner','Reward the runner. Doesn’t feel like a fast break but most folks weren’t back and Kawhi was all alone',NULL,35,'https://www.reddit.com/r/nba/comments/1afz9za/highlight_russell_westbrook_hits_kawhi_with_the/',0.1531,0.19,0.694,0.116),
	 ('2024-02-01','Immediatewhaffle','I still fully believe this dude is gunna be nasty','Knicks',35,'https://www.reddit.com/r/nba/comments/1afym20/highlight_jeremy_sochan_pulls_out_the_reverse/',-0.5574,0,0.69,0.31),
	 ('2024-02-01','SnorkelTeamSix','Goddamn you are soft asf','USA',35,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',-0.4767,0,0.563,0.437),
	 ('2024-02-01','ABagOfPopcorn','He’s the only recent major trade deadline move I can think of that led to a chip the same year','76ers',35,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0,0,1,0),
	 ('2024-02-01','ygog45','1 game off the 2 seed. Thanks Blazers','Knicks',35,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.4404,0.367,0.633,0),
	 ('2024-02-01','maidentaiwan','I’ve seen no evidence that a healthy kawhi isn’t the best player in any playoff series when healthy since he won the title with Toronto. Just look at him outgunning an otherworldly Luka in 2021. He just hasn’t been able to consistently stay on the court since then. We’ll see what happens this year if the clips go into the playoffs at full fitness. I back them against anyone.','NBA',35,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.9217,0.196,0.776,0.028);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','fckthisite','Yeah I know lol',NULL,35,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.6124,0.833,0.167,0),
	 ('2024-02-01','Briggity_Brak','Exactly. We need to stop looking at per game averages and start caring more about season totals like every other sport in the world.','TampaRaptors',35,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',0.5423,0.197,0.727,0.076),
	 ('2024-02-01','sylvestersquad','You’d assume but [people hate everything he does](https://x.com/thehoopcentral/status/1752905173838774434?s=46&t=yiqopw60-vigqyq-yeqL2A) just read some of the comments','Suns',35,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',-0.7227,0,0.72,0.28),
	 ('2024-02-01','JewBronJames','Nobody cares about the truth it’s all a narrative game with AD',NULL,35,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.6486,0.371,0.629,0),
	 ('2024-02-01','DubsFanAccount','The main problem with that argument is 1) they’re not. Football is obviously the big counter example. NFL and college. 2) they’re declining faster than average and the important one 3) NBA depends on TV revenue more than other sports.

For example, NBA used to kill MLB in TV ratings. Now they’re really close. But the MLB doesn’t care as much bc so much of their revenue comes from attendance. NBA meanwhile depends a lot on TV ratings and now they draw less than an episode of Chicago Fire or Law and Order. The Lakers Warriors double OT game isn’t going to crack the top ten for the week. It would have ten years ago.','Warriors',35,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.1655,0.063,0.86,0.077),
	 ('2024-02-01','Thermicthermos','I think its specifically the hardcore fans and analysts that watch 6 games in a night like Russillo not the hot takes and highlights crowd.','Mavs',35,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.3612,0.106,0.894,0),
	 ('2024-02-01','XzibitABC','Basketball is a contact sport. If you get a slightly ahead of a guy, you aren''t entitled to be untouched on your way to the basket. This kind of incidental contact should be a no call.','Pacers',35,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.4614,0,0.882,0.118),
	 ('2024-02-01','TB_016','The exposure alone is great for them. Someone in a thread today said Scoot isn''t even a top 10 rookie this season. Sucks that we now have to go back to the NBA shadow realm.','TrailBlazers',35,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.0021,0.105,0.74,0.155),
	 ('2024-02-01','Mattoosie','Yes, but also Russillo is one of the most dedicated basketball fans in the media. He watches a TON of games and knows what he''s talking about.

I read that as "if *I* don''t find this enjoyable, then what the fuck do the millions of casual fans think? If you lose me, they were already long gone."','Raptors',35,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.5792,0.186,0.696,0.118),
	 ('2024-02-01','Gbaby245','Gotta pay off a big guy running the floor.  Love to see it.','Timberwolves',35,'https://www.reddit.com/r/nba/comments/1afzqhm/highlight_rudy_gobert_makes_it_difficult_for/',0.5859,0.269,0.641,0.09);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','StuckInBronze','That Nuggets series was ridiculous.',NULL,34,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',-0.3612,0,0.615,0.385),
	 ('2024-02-01','Heibaihui','Man, they still don''t acknowledge he got fouled.

Stop acting like you are the CCP!','Grizzlies',34,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.1511,0.155,0.723,0.122),
	 ('2024-02-01','MC-Jdf','He improvised that to double Dame instead of letting him go 1 on 1 against Ayton. Super neat play.','Warriors',34,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.8519,0.399,0.601,0),
	 ('2024-02-01','victheogfan','As much as I agree KD outright stated he didn’t want one too, it’s good they kept it short tho','Heat',34,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.6908,0.295,0.705,0),
	 ('2024-02-01','mmaguy123','Mikal ain’t laughing 😂😂',NULL,34,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.4939,0.516,0.484,0),
	 ('2024-02-01','everyoneneedsaherro','How much Kawhi is jacked is massively underrated. Hes like Sabonis where he’s built like a tank but doesn’t look it','NBA',34,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.3612,0.163,0.837,0),
	 ('2024-02-01','Radical-Six','We embrace every part of winter up here','Timberwolves',34,'https://www.reddit.com/r/nba/comments/1ag2hl8/highlight_target_center_goes_crazy_for_free/',0.3182,0.247,0.753,0),
	 ('2024-02-01','captain_ahabb','Seems like people are willing to not understand quite a bit when it comes to Embiid','Lakers',34,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.3612,0.152,0.848,0),
	 ('2024-02-01','693275001','Cut from the same hooper cloth','Celtics',34,'https://www.reddit.com/r/nba/comments/1ag192x/kd_with_some_friendly_trash_talk_to_his_friend/',-0.2732,0,0.704,0.296),
	 ('2024-02-01','DemarcusLovin','>Or worst of all, because I hoop on a regular, I make a cut and my knee completely gives and I can''t walk without assistance for a week and can''t get comfortable because I''m in pain. Last part happened to me a couple months ago and I just got back in the gym this last weekend.

Hate to tell you bro, but sounds like you’re close to needing to retire from playing basketball','NBA',34,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',-0.459,0.074,0.785,0.141);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','Mosh00Rider','You realize how much more petty people are with their family? Same shit','Suns',34,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',-0.6901,0,0.659,0.341),
	 ('2024-02-01','ColdNyQuiiL','I thought KP to Boston was amazing as soon at it happened. He was relatively healthy with the Wizards, and showed how good he was before the injuries. Seemed like a risk worth taking. 7 foot versatile 3 point shooters are exactly falling out of the sky, and Boston takes a lot of damn 3’s anyway.

Seemed like a nightmare for opponents, and I’ve been rooting for KP since his time in Dallas was injury ridden.',NULL,34,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.7964,0.191,0.702,0.108),
	 ('2024-02-01','KaleAdditional776','Sail the high seas brother! It’s pretty easy to do!','Mavs',33,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.7707,0.455,0.545,0),
	 ('2024-02-01','KingMessiah13','LOL no',NULL,33,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.3254,0.616,0,0.384),
	 ('2024-02-01','YouDaMANRAJ','LOL. TRUE. guy will make the hardest double clutch reverse layups and then airball a wide open layup in the same game','Clippers',33,'https://www.reddit.com/r/nba/comments/1afz9za/highlight_russell_westbrook_hits_kawhi_with_the/',0.7944,0.271,0.729,0),
	 ('2024-02-01','Heibaihui','I am out of the loop, I know Ant got fouled by SGA and trashing the refs, but how is Pat Bev involved in this','Grizzlies',33,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',0,0,1,0),
	 ('2024-02-01','Zeppelanoid','You don’t say','Raptors',33,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0,0,1,0),
	 ('2024-02-01','Responsible_Pace9062','She should have known that would happen on showing a convo with an AI picture of a baby with the caption ''Look how cute tho 💔''',NULL,33,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.4588,0.115,0.885,0),
	 ('2024-02-01','syllabic','never forgive him for having to go to canada to cover the finals','Knicks',33,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.2057,0,0.869,0.131),
	 ('2024-02-01','syllabic','voters have always taken games played into account

there''s always going to be a minimum, can you give MVP to someone who plays 50% of the season?  what about 25%?','Knicks',33,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.5803,0.15,0.85,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','RansomGoddard','Usually the move there is for the inbounder to get the ball back instantly while on a sprint downhill so defenders can’t just foul him right when he gets the ball.

The ball just didn’t get back to Dame like it was supposed to.

That said the dumb part is that they shouldn’t be inbounding the ball to a bad FT shooter.','Heat',33,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',-0.5512,0.063,0.835,0.101),
	 ('2024-02-01','jorgelongo2','He was perfectly fine vs Spurs, its almost as if injuries happen at a specific point in time ( middle of the game vs Pacers)',NULL,33,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.7184,0.222,0.778,0),
	 ('2024-02-01','Miamime','>I wouldn''t wish it on anyone.

Lol wtf. Wish it on me. Dude is getting $10M a year to coach Dame and Giannis.','76ers',33,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',-0.1426,0.186,0.609,0.205),
	 ('2024-02-01','Mediocre_Peanut7615','Mavs didn''t fuck up terribly, they didn''t do an amazing job either, but this is far from the worst team build. They have a perfect setup for Luka to run a spread pick and roll, they have good shooters. The problem is they don''t have much else when Kyrie is out, but they are doing a good job of maximizing the Luka part, we''ve seen worse.','Thunder',33,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.0647,0.193,0.628,0.179),
	 ('2024-02-01','blueborders','Much of the subreddit doesn''t know what it''s like to have friends','Suns',33,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.6808,0.359,0.641,0),
	 ('2024-02-01','MoltenPandas200','Dare accepted. The Wolves have taken 27 fta vs the Thunder''s 24 in their four games. Shai has taken 10.5 FTA per game vs Ant''s 8.3

That''s not enough context to really come to any conclusions, but I think it''s safe to say that you are also doing too much','Bucks',33,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',0.6597,0.103,0.897,0),
	 ('2024-02-01','snyckers','I would''ve just put the video of his foot on the line replayed from every angle.','Warriors',33,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0,0,1,0),
	 ('2024-02-01','Jonny_Stranger','11-7 not bad for a supposed month of hell','Thunder',33,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',-0.4118,0.212,0.446,0.342),
	 ('2024-02-01','Kirk_likes_this','Yes exactly. He chose to protect his MVP campaign and basically forfeit a game rather than risk getting outplayed and he didn''t even really bother trying to sustain any plausibility about whether or not he was really hurt. He dropped the act as soon as the game was over.

If he''d just sucked it up and taken his lumps for that one game the ducking narrative would be dead but instead he all but signed a written confession admitting it was real. If people are skeptical of him now it''s his own fault.',NULL,33,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.868,0.052,0.801,0.147),
	 ('2024-02-01','beatnickk','Without a doubt? Man he was awesome for them but i think it could pretty easily be considered Lowry or Siakam as well. Kawhi and Siakam were breaking records as scoring duos in the finals','Mavs',33,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.921,0.336,0.664,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','MAMBAMENTALITY8-24','I like this from booker','Thunder',33,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.3612,0.455,0.545,0),
	 ('2024-02-01','lxkandel06','Shout out Dennis Smith Jr.','Nets',32,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0,0,1,0),
	 ('2024-02-01','is-Sanic','"MVP" Most valuable player.

Not "Most Valuable player on a good team".','NBA',32,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.5457,0.369,0.469,0.162),
	 ('2024-02-01','Old-Objective-9783','"No, Dot Com! I said,''Give to charity? Please, no! PRESENTS!''"',NULL,32,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.5826,0.422,0.423,0.155),
	 ('2024-02-01','pjtheMillwrong','I am pointing out the media showed more leniency than the rule and I didn''t see people complaining about All NBA selections last year.','Raptors',32,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.1511,0.07,0.93,0),
	 ('2024-02-01','chungking-espresso','The Blazers were giving away some insane turnovers there at the end, I was scared for them, lol.','BRA',32,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',-0.1027,0.218,0.546,0.235),
	 ('2024-02-01','KillingTime_ForNow','We did it for Josh Hart.','TrailBlazers',32,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0,0,1,0),
	 ('2024-02-01','cb148','Or in his 9 million dollar Manhattan Beach pad a block from the beach.','Lakers',32,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.4404,0,0.791,0.209),
	 ('2024-02-01','Apollo611','Come on guys!','Lakers',32,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0,0,1,0),
	 ('2024-02-01','HuruHara','I''ve always believed in Scoot.','Timberwolves',32,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','DiCaprio_Too','Looked awkward but was involved in every shot in those plays','Thunder',32,'https://www.reddit.com/r/nba/comments/1ag14vv/highlight_holmgren_hits_daggers_triple_with_vs/',0.296,0.195,0.703,0.102),
	 ('2024-02-01','InTheMorning_Nightss','It was a super obvious thing to do.  Awful free throw shooter gets it with game on the line? Yeah, of course you should hack them.','Clippers',32,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0.7506,0.281,0.629,0.09),
	 ('2024-02-01','yungshiner281','Giannis already getting his humble offseason speech ready','Celtics',32,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.3612,0.263,0.737,0),
	 ('2024-02-01','ifreddiebenson','Simons Time',NULL,32,'https://www.reddit.com/r/nba/comments/1ag3nvh/highlight_anfernee_simons_with_the_tough_runner/',0,0,1,0),
	 ('2024-02-01','knowtoriusMAC','If you miss 25% of the regular season from being injured you shouldn''t be eligible for regular season awards.','Knicks',32,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.0772,0.129,0.687,0.185),
	 ('2024-02-01','InTheMorning_Nightss','I think Beal *could* have played more games, but people are pretty much ignoring the other entity in this conversation: the team''s themselves.

Why would the Wizards want to play Beal, who has a lingering injury, when they''re out of the playoffs?  You know exactly what you get with Beal, so it makes sense to want to give guys like Deni, Kispert, etc. more minutes to develop.

Similarly, for LAC, Kawhi and PG both want to play.  You literally see it whenever any guy has a minutes restriction.  They get pulled off the court in a close game, and then are pissed off because they want to play.  But the organization believes (even if incorrectly) that load management helped their health in the long term, which these teams will then abide by because these guys are long term investments.

The question of "Could this player force themselves to play through injury?" is drastically different than, " Are these guys sitting out because they don''t want to play?"','Clippers',32,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.829,0.154,0.764,0.082),
	 ('2024-02-01','augustus624','Yeah, I already said, the Sixers medical staff are the most to blame and Embiid should''ve ignored the noise.

Doesn''t mean the discourse from the media after the Nuggets game wasn''t stupid as hell however. And the Day to Day Davis/street clothes stuff from the media is stupid as hell as well',NULL,32,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.9042,0.264,0.66,0.076),
	 ('2024-02-01','IDKaboutthatone','One of the best shot makers in the league. Hold dat.','TrailBlazers',32,'https://www.reddit.com/r/nba/comments/1ag3nvh/highlight_anfernee_simons_with_the_tough_runner/',0.6369,0.296,0.704,0),
	 ('2024-02-01','-ci_','Ain''t shit funny','Celtics',32,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.1326,0.462,0.158,0.38),
	 ('2024-02-01','Seraphin_Lampion','Yeah this is the real WTF.',NULL,32,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.516,0.205,0.373,0.422);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','SerenadeSwift','And hell the Suns have two guys on the MVP ladder and they’re only 1 game up on the Mavs..','SuperSonics',32,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.6808,0,0.796,0.204),
	 ('2024-02-01','elkresurgence','The only one to get one on a lower-seeded team was Westbrook, who had a statistically historic season, although Harden''s campaign that year (29-8-11 on better efficiencies) was arguably more impressive. That''s just how people are swayed by the spectacle argument when it comes to MVP votes. I think Luka can still get it this season on a lower seed (5\~6) if he either averages 35-10-10 or exceeds Harden''s 36.1 with close to double-digit rebounds and assists','NBA',32,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.2006,0.08,0.838,0.083),
	 ('2024-02-01','K1NG2L4Y3R','It all depends on reputation. Guys like Draymond get the benefit of doubt a ton. Smaller guys playing up are also allowed to absolutely hack bigs and receive no foul call too.',NULL,32,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',0.3818,0.192,0.684,0.124),
	 ('2024-02-01','ripcity_pilgrim','Where are my "Scoot hasn''t shown any flashes" people hiding tonight?',NULL,32,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',-0.296,0,0.82,0.18),
	 ('2024-02-01','defiantcross','lol i missed the nurk thing.  when was that?','Suns',32,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.1531,0.255,0.545,0.2),
	 ('2024-02-01','Cloakington','Richard Jefferson was peddling that shit during the nuggets game, it’s nuts','76ers',32,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.7096,0,0.629,0.371),
	 ('2024-02-01','Mitrakov','That''s a lie','Nuggets',32,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0,0,1,0),
	 ('2024-02-01','sorendiz','Someone should probably have told him that before those fts tonight ','Rockets',32,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0,0,1,0),
	 ('2024-02-01','floatermuse','Obviously Tatum is better defensively than Luka but if perimeter defense makes up that offensive gap then Gary Payton is equal to Steph Curry lol 

 Individual defense is simply not as valuable as individual offense and in particular perimeter defenders are more a part of a good overall  team defense than a one-man defense by themselves(if you put prime Kawhi on a team with Enes Kanter starting at C the defense will still be bad)',NULL,32,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.7153,0.228,0.646,0.126),
	 ('2024-02-01','Dsarg_92','That Grit and Grind era was something special.','Spurs',31,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0.4019,0.278,0.722,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','Salty_Watermelon','A Zach Lowe podcast where he spends half of it gushing over Kawhi.  I wish I was being sarcastic.','Clippers',31,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.296,0.219,0.677,0.104),
	 ('2024-02-01','KevinDurantLebronnin','The worst is how often you see a player go up without the slightest intention of putting the ball through the rim. The "shot" is just some disgusting body contortion to get their 2 FTAs.','Suns',31,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.8176,0,0.805,0.195),
	 ('2024-02-01','iguessineedanaltnow','That one felt good. I needed that win.','TrailBlazers',31,'https://www.reddit.com/r/nba/comments/1ag3pwx/damian_lillard_loses_in_his_return_to_portland/',0.7717,0.573,0.427,0),
	 ('2024-02-01','Dusty_Negatives','It started when there was an error on active roster and Doc had the decision to not let CJ play in a playoff game. Terry talked shit and it started there.  Over the years you could tell they disliked one another. Him and Chris Paul were so damn annoying in postseason bitching to refs all 48 mins etc.  Just 2 teams that ended up hating each other.','TrailBlazers',31,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',-0.9596,0.033,0.686,0.281),
	 ('2024-02-01','captcanuk','He’s back to championship form. He won in 2014, 2019 and now it’s 2024. FMVP both times with different teams.  Set your clocks!',NULL,31,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.784,0.247,0.753,0),
	 ('2024-02-01','geewillie','Yeah this is just hilariously dumb from the 76ers and Embiid lol',NULL,31,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.1779,0.289,0.52,0.191),
	 ('2024-02-01','comp_a','It’s so weird how people keep trying to frame it as a punishment—it’s a reward! If a player performs well and is available 95-100% of the time, they absolutely deserve to be rewarded for that.','Timberwolves',31,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',0.8073,0.237,0.713,0.051),
	 ('2024-02-01','FxStryker','We''re now the 5th with our starting 5 injured. Fun times.','76ers',31,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.1531,0.236,0.571,0.193),
	 ('2024-02-01','EllisDSanchez','We know how to fan.','TrailBlazers',31,'https://www.reddit.com/r/nba/comments/1ag3qrn/highlight_giannis_misses_both_fts_to_close_the/',0.3182,0.365,0.635,0),
	 ('2024-02-01','SnorkelTeamSix','No but your sister does.','USA',31,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',-0.1531,0,0.714,0.286);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','Killyouifyouuseemoji','The Tyson Chandler disrespect',NULL,31,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.4215,0,0.517,0.483),
	 ('2024-02-01','tyler1118','KD pointing and laughing is hilarious. lmao','Suns',31,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.8689,0.71,0.29,0),
	 ('2024-02-01','Next-Firefighter-753','Literally the only good thing to come from him was that offensive rebound and the pass to Chet for the dagger.

I can see him getting traded if he doesn’t take a discount this offseason. Presti doesn’t let players hit RFA and he’s not playing like a big money guy right now. Not even close. ','Thunder',31,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',-0.4218,0.05,0.833,0.116),
	 ('2024-02-01','applep00','the same reason kidd didnt do it when hardaway was stuck vs orlando…just spectating the game like the rest of us','Celtics',31,'https://www.reddit.com/r/nba/comments/1ag3pwx/damian_lillard_loses_in_his_return_to_portland/',0.128,0.106,0.809,0.085),
	 ('2024-02-01','GetQuakedOnIsABITCH','sub wont like this one',NULL,31,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',-0.2755,0,0.655,0.345),
	 ('2024-02-01','HisExcellency20','I''m so sick of the discourse around Joel Embiid. Everyone *always* assumes the worst in him.

He didn''t play in Denver. You could assume he was hurt, but it''s Joel so you assume he''s ducking. He plays and looks hobbled in GS. You could assume he wants to help his team win games, but no it''s Joel so it must be the 65 games minimum.

Just fuck the entire NBA discourse as a whole. There''s a reason why they have to beg fans to watch regular season games with a gimmick like the IST.','76ers',31,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.099,0.13,0.726,0.144),
	 ('2024-02-01','littledoopcoup','Also like the coaches and front office aren’t on board with it. Guys like Kawhi sit because their coaches and GMs think it’s a good idea to rest them. Pop and the Spurs did it explicitly because Duncan needed rest. We know this already. If my boss told me to stay home and I was on the schedule, I’d still expect to be paid.','76ers',31,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.7845,0.118,0.882,0),
	 ('2024-02-01','Kwilly462','It''s pretty much NBA protocol to do a tribute video to a former player. It''s that simple. Not a big deal.','Nets',31,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',0.4939,0.158,0.842,0),
	 ('2024-02-01','GuyOnHudson','Please kink shaming here','Timberwolves',30,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',0.3182,0.434,0.566,0),
	 ('2024-02-01','Klunko52','Define no reason','Warriors',30,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',-0.296,0,0.476,0.524);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','Theis159','Add the big 3 Celtics, only having 1 ring to show with that team shows how hard is to win with Doc as a coach','Celtics',30,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.5267,0.151,0.794,0.056),
	 ('2024-02-01','Checkmynewsong','Paul Westhead vibes.','Lakers',30,'https://www.reddit.com/r/nba/comments/1afrgit/elfrid_payton_on_former_coach_david_fizdale_we_go/',0,0,1,0),
	 ('2024-02-01','Babushka5','What was Chauncey''s reason for not calling time out when the Bucks trapped Simons?','Celtics',30,'https://www.reddit.com/r/nba/comments/1ag3pwx/damian_lillard_loses_in_his_return_to_portland/',-0.5267,0,0.793,0.207),
	 ('2024-02-01','DA_ReasoN','Wait... Where''s the tribute video? Kevin Durant got a short one from The Nets, Don''t tell me Portland didn''t have one ready for Dame''s return.','Knicks',30,'https://www.reddit.com/r/nba/comments/1ag0yzr/highlight_lillard_is_welcomed_to_moda_center_to_a/',-0.2755,0,0.916,0.084),
	 ('2024-02-01','hydroknightking','I think my first comment got deleted cause I didn’t link the post as no participation.

https://www.np.reddit.com/r/nfl/s/LxHsPViNp9

But no, Belichick was pissed off at reporters questioning if Brady was avoiding the injury list cause he was icing his shoulder after practice','Celtics',30,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.9559,0,0.64,0.36),
	 ('2024-02-01','ArjunBanerji27','This is a pathetic spin to get attention off the fact that the Sixers organization and medical staff cleared him to play in Denver, took him off 15 minutes before the game, and then allowed him to play yesterday when he clearly hadn''t recovered.

Trying to push the narrative that Embiid got bullied into playing by social media pressure is the least believable explanation they could have come up with.

And even if that was true, it wouldn''t reflect well upon the Sixers medical staff. You just let your injury prone superstar rush out to play, and re-injure himself, because he got tilted by twitter trolls?',NULL,30,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.1813,0.129,0.753,0.118),
	 ('2024-02-01','Aggressive_Slice4620','Production wise, yes, mostly because he barely gets any playing time. He was slow to adjust to the speed of the NBA and the coach barely used him until this brutal January stretch. Since getting a bit more playing time this month he just keeps getting better and better. There were times wherein the 5-man rotation with him and Jdub are better than SGA plus shooters.','Thunder',30,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',0.8657,0.221,0.717,0.061),
	 ('2024-02-01','poeope','It was perfect.  Down to it being right in front of the Blazers bench so that Grant could hear his coach screaming to foul.

A singular moment in play design.','Celtics',30,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.7414,0.243,0.685,0.071),
	 ('2024-02-01','SerenadeSwift','Jokic won it as the 6 seed','SuperSonics',30,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.5719,0.425,0.575,0),
	 ('2024-02-01','bewarethegap','imagine getting your ankles utterly broken in a tribute video that the guy didn''t even want','Thunder',30,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',-0.5596,0,0.738,0.262);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','NavalEnthusiast','He also picked “Shamander” as his starter pokemon because in his eyes they share similar facial features','Thunder',30,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.296,0.121,0.879,0),
	 ('2024-02-01','Even_Note_1604','i thought he meant it in like "it''s muscle memory" kind of way.',NULL,30,'https://www.reddit.com/r/nba/comments/1afy0gl/nehm_damian_lillard_on_walking_into_the_visitors/',0.3612,0.185,0.815,0),
	 ('2024-02-01','Potencyyyyy','Him and SGA gonna run this league for like 20 years we are fucked y’all.

GG Thunder that was a fun one to watch.','Nuggets',30,'https://www.reddit.com/r/nba/comments/1ag14vv/highlight_holmgren_hits_daggers_triple_with_vs/',0.516,0.272,0.591,0.137),
	 ('2024-02-01','BlueJays007','It’s why I always laugh when people say Tatum has had a great team every single year.

Tatum had to score 50 to win a play in game vs the Wizards that year with Jaylen out. We started Romeo Langford and Tristan Thompson in a playoff game. And he still got us that win vs the Nets big 3 (while needing to use an inhaler due to breathing complications from long covid).','Celtics',30,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.9565,0.222,0.778,0),
	 ('2024-02-01','Absol61','He''s also lowkey been the one the best defenders in the NBA, and honestly should be the DPOY.','Nuggets',30,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0.8176,0.362,0.638,0),
	 ('2024-02-01','TheFestusEzeli','I do wonder if there is any action that Embiid can do that people would not spin into “he is only doing it for the MVP!”

Sits out, oh it’s because he is scared and doesn’t want to lose MVP. Plays, oh it’s because he is scared and doesn’t want to win MVP.

Of course the Sixers medical staff is at fault too, that doesn’t make any of the brain dead takes by this sub any less stupid. I fucking hate the Sixers but have defended Embiid over the years here because this sub’s views and takes on him are insane.','Raptors',30,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.9064,0.056,0.779,0.166),
	 ('2024-02-01','KARSbenicillin','Think of it this way. When you''re at work you sometimes get put into a different department to help widen your capabilities even if you aren''t gonna be working in that position. You''re basically deadweight there for that time but once you get back to your main job you might be able to contribute in broader ways. Same thing with Sochan.',NULL,30,'https://www.reddit.com/r/nba/comments/1afym20/highlight_jeremy_sochan_pulls_out_the_reverse/',0.2144,0.03,0.97,0),
	 ('2024-02-01','anon641414','Wemby: Look at this guy putting up insane numbers while carrying a terrible team to 35 wins. Clear MVP

Luka: This guy is just putting up inflated numbers on a terrible team. He shouldn''t even sniff the MVP.

This will most likely be the logic',NULL,30,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.3818,0.118,0.714,0.167),
	 ('2024-02-01','FoShzzleMsFrizzle','Players feel like they should play all the time, and frankly it’s on the team to override that. The sixers are so fuckass','76ers',30,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.5994,0.189,0.811,0),
	 ('2024-02-01','Avid_MCGardener_27','What having Doc as a head coach does to players',NULL,30,'https://www.reddit.com/r/nba/comments/1ag3pwx/damian_lillard_loses_in_his_return_to_portland/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','shutemdownyyz','11-6* but we did as well as most had hoped for','Thunder',29,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',0.7556,0.418,0.582,0),
	 ('2024-02-01','Surflover12','If embiid doesnt play enough games it should be luka','Raptors',29,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.2584,0,0.816,0.184),
	 ('2024-02-01','PrimalGenius','The blazers are hellbent on making sure Dame loses, no matter what team he''s on. (I love you sm bb come back)','TrailBlazers',29,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.4767,0.261,0.584,0.155),
	 ('2024-02-01','shaad20','I felt completely the opposite? That was a pretty wholesome moment','Suns',29,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.4939,0.286,0.714,0),
	 ('2024-02-01','Goducks91','We''re finally almost healthy and a better team then people think. Not good, but not god awful haha','TrailBlazers',29,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',-0.1033,0.271,0.442,0.287),
	 ('2024-02-01','MikeJeffriesPA','That and his passing, it made the pick and pop even more deadly. ','Raptors',29,'https://www.reddit.com/r/nba/comments/1afn9sg/cole_marc_gasol_has_officially_announced_his/',0,0,1,0),
	 ('2024-02-01','mickelboy182','I saw a Wizards fan say, without even a hint of irony, ''I hope you''re happy now, Nuggets fans''.

We shot Bambi.','Nuggets',29,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0.8271,0.355,0.598,0.048),
	 ('2024-02-01','Domin0x','So you think his knee condition was fake? Then why he was visibly limping in 2019 playoffs, was he faking it?

2021 he teared his ACL which prevented him from playing the next year.

2023 he was sat out some games especially in the 1 st half of the season because he was still not 100% after that injury. If you watched him play in the 2nd half of the season it was like night and day.

Then in the playoffs he teared his meniscus and had to have a surgery in summer(which also casued him to start the season slowy, he didn''t miss that many games but was obviously struggling in the first couple of weeks.','NBA',29,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.6992,0.058,0.862,0.081),
	 ('2024-02-01','twin_beak','I believe him','Lakers',29,'https://www.reddit.com/r/nba/comments/1afy0gl/nehm_damian_lillard_on_walking_into_the_visitors/',0,0,1,0),
	 ('2024-02-01','Babushka5','Kyle Anderson changed the game','Celtics',29,'https://www.reddit.com/r/nba/comments/1ag3nvh/highlight_anfernee_simons_with_the_tough_runner/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','EPLemonSqueezy','I can''t stand him but he''s obviously right. All these guys who''ve been load managing for years have all suddenly been cured and are able to play every game. It''s not rocket surgery.','Raptors',29,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.4767,0.091,0.909,0),
	 ('2024-02-01','defiantcross','Lively is extremely promising.  with our team can draft like that.','Suns',29,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0.8122,0.512,0.488,0),
	 ('2024-02-01','Headlesshorsman02','The terminator','Thunder',29,'https://www.reddit.com/r/nba/comments/1afzjbb/azarly_kawhi_leonard_is_shooting_575090_over_his/',0,0,1,0),
	 ('2024-02-01','SnorkelTeamSix','Good this sub a buncha hoes ','USA',29,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.4404,0.42,0.58,0),
	 ('2024-02-01','fantasnick','Pat Bev is probably the current #1 in the NBA for internet content','West',29,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',0,0,1,0),
	 ('2024-02-01','mmaguy123','He’s just joking around dude calm down lmao.',NULL,29,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',0.7964,0.618,0.382,0),
	 ('2024-02-01','AlmightyRanger','Best comment.','Suns',29,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',0.6369,0.808,0.192,0),
	 ('2024-02-01','firstbreathOOC','“I don’t know what that means,” - me','Knicks',29,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',0,0,1,0),
	 ('2024-02-01','dracota7','Dort 3ball is back','Thunder',29,'https://www.reddit.com/r/nba/comments/1ag1911/post_game_thread_the_oklahoma_city_thunder_3315/',0,0,1,0),
	 ('2024-02-01','jinxabcde','Send da video','TampaRaptors',29,'https://www.reddit.com/r/nba/comments/1afrsm0/krawczynski_karlanthony_towns_has_issued_a/',0,0,1,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','scarrylary','The game was absolutely not harder back then… the athleticism from the 12th men in todays game would blow peoples minds in the 80s. Just cuz they punched people and flagrants weren’t a thing doesn’t mean it was harder. Most injuries are because today’s athletes are pushing their bodies to the absolute limits that a human can achieve.','Cavaliers',29,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',0,0,1,0),
	 ('2024-02-01','Alex_Sander077','Maybe here. But not by the national media which is what I was talking about.','Mavs',29,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',0,0,1,0),
	 ('2024-02-01','NoPin5154','Ad literally never load managed bro was just crippled for the better part of two years',NULL,28,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.4404,0.162,0.838,0),
	 ('2024-02-01','ironfly187','I''m not sure what point he was trying to make about Durant. That he plays fewer games now that he''s older and has had increasing number of injuries? Well, that''s to be expected, isn''t it?',NULL,28,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0.4211,0.149,0.801,0.051),
	 ('2024-02-01','calman877','I think playing in the NBA is fundamentally tougher on the body than it was 20 or 30 years ago. Players are moving more, changing directions faster than ever before. It’s rough on the joints and leads to more injuries. In the 80s, 90s, and even 2000s guys were just planted in the paint area and barely had to move, now you have to close out on 3pt shooters and potentially switch to contest drives every play. Combine that with players playing AAU and sometimes five games in a day when they’re growing up and it’s pretty clear why injuries are going up. AAU culture didn’t pick up until fairly recently.

Load management is meant to reduce injury risk from what it would otherwise be, not what it would be in the past.','76ers',28,'https://www.reddit.com/r/nba/comments/1afup4o/marks_my_thoughts_on_the_65game_policy_last/',0.8074,0.107,0.859,0.034),
	 ('2024-02-01','JeramiGrantsTomb','They didn''t make this rule to ensure that the people who get the contracts "deserve" it.  They made the rule to get the players to stop skipping games.  They don''t care if the players are adequately compensated, they care that people buy tickets or advertisers buy airtime, and then half the stars skip the game, and eventually that means the money dries up.','Thunder',28,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',-0.5935,0.038,0.854,0.108),
	 ('2024-02-01','timbbooooslice','then why not put him as GTD or questionable against the nuggets instead of pulling him 15mins before tip-off.

Dude didn''t even look right last night so no way was he ready to play against the nuggets....','Raptors',28,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.0429,0.114,0.768,0.118),
	 ('2024-02-01','WheatonsGonnaScore','Because they wanted to win. He struggled in the second half and got taken out when he started turning the ball over',NULL,28,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0.34,0.145,0.763,0.092),
	 ('2024-02-01','orphan_tears_','I get your point, but most 7 seeds would be lottery teams without their best player.','Warriors',28,'https://www.reddit.com/r/nba/comments/1afpq4r/luka_is_only_06_ppg_behind_embiid_for_the_scoring/',-0.6759,0,0.741,0.259),
	 ('2024-02-01','Obvious_Parsley3238','that was 100% a travel but they''re up 20 against the wizards so who cares lmao',NULL,28,'https://www.reddit.com/r/nba/comments/1afz9za/highlight_russell_westbrook_hits_kawhi_with_the/',0.9035,0.439,0.561,0);
INSERT INTO reddit_comments (scrape_date,author,"comment",flair,score,url,compound,pos,neu,neg) VALUES
	 ('2024-02-01','LordSwampert2','He’s gonna retire with yall and the City jersey for the year better be Dame themed. He looked good as hell in those ones yall had last year. They were underrated','Bulls',28,'https://www.reddit.com/r/nba/comments/1afy0gl/nehm_damian_lillard_on_walking_into_the_visitors/',0.0516,0.151,0.729,0.12),
	 ('2024-02-01','OrangeCrush815','Wait... so the 76ers medical staff had all the final decision-making power in Denver.  Nothing on the injury report, but they decided to sit Embiid in the 11th hour to protect his health. 


Yet last night... either the.medical staff deemed Embiid healthy... OR... the medical staff can be overruled by Embiid.  The player can overrule if his feelings have been hurt by "mean" fans and media.


This is mind-numbing incompetence from everyone involved from the 76ers... including Embiid.    ',NULL,28,'https://www.reddit.com/r/nba/comments/1afl0wp/amick_people_within_the_sixers_organization/',-0.717,0.057,0.84,0.103),
	 ('2024-02-01','Vicentesteb','Tbh, what can the refs even say if the Thunder straight up say, "We fouled him"','Timberwolves',28,'https://www.reddit.com/r/nba/comments/1afnqa2/nba_pr_anthony_edwards_has_been_fined_40000_for/',0.2263,0.112,0.888,0),
	 ('2024-02-01','HilariousScreenname','Aw man now I feel bad','Suns',28,'https://www.reddit.com/r/nba/comments/1ag1yvu/highlight_booker_hits_mikal_with_his_own_3point/',-0.5423,0,0.533,0.467),
	 ('2024-02-01','j_cruise','Definitely would. The Nets give tribute videos to even bench players who didn''t get many minutes. It''s just that they are usually only seen in the arena and don''t get much press. People just like getting outraged about shit.','Nets',28,'https://www.reddit.com/r/nba/comments/1afz16t/highlight_kevin_durant_doesnt_look_too_amused_as/',-0.4404,0.11,0.74,0.15),
	 ('2024-02-01','thenicezen','hey at least we got rid of Griffin, they say…','Bucks',28,'https://www.reddit.com/r/nba/comments/1ag3sda/post_game_thread_the_portland_trail_blazers_1533/',0,0,1,0),
	 ('2024-02-01','Confident_Berry7271','He shat on kawhi for tearing his meniscus. What do you mean? ',NULL,28,'https://www.reddit.com/r/nba/comments/1aflznu/stephen_a_lists_guys_like_kawhi_paul_george_kevin/',0,0,1,0),
	 ('2024-02-01','horse_renoir13','POH-LICE PRESENCE

*throws papers*','Timberwolves',28,'https://www.reddit.com/r/nba/comments/1afy0gl/nehm_damian_lillard_on_walking_into_the_visitors/',0,0,1,0),
	 ('2024-02-01','XzibitABC','I''m not typically a "man that ref specifically sucks" guy, but Ted Valentine needs to be shot into the sun.','Pacers',28,'https://www.reddit.com/r/nba/comments/1aft64o/ryen_russillo_tells_the_official_nba_referee/',-0.1901,0,0.911,0.089);

DROP TABLE IF EXISTS injuries;
CREATE TABLE injuries(
	player text NULL,
	team text NULL,
	team_acronym text NULL,
	injury text NULL,
	injury_status text NULL,
	injury_description text NULL,
	scrape_date date NULL
);

INSERT INTO injuries (player,team,team_acronym,injury,injury_status,injury_description,scrape_date) VALUES
	 ('A.J. Green','Milwaukee Bucks','MIL','Ankle','Out','Green is OUT for Sunday''s (Apr. 14) game against Orlando.','2024-04-15'),
	 ('Jaylin Galloway','Milwaukee Bucks','MIL','Ankle','Out','Galloway is OUT for Sunday''s (Apr. 14) game against Orlando.','2024-04-15'),
	 ('Giannis Antetokounmpo','Milwaukee Bucks','MIL','Calf','Out','The Bucks announced that Antetokounmpo will miss the final three games of the regular season.','2024-04-15'),
	 ('Jontay Porter','Toronto Raptors','TOR','Personal Reasons','Out','Porter is OUT for Monday''s (Mar. 25) game against Brooklyn.','2024-04-15'),
	 ('Jakob Poeltl','Toronto Raptors','TOR','Finger','Out','The Raptors announced that Poeltl had surgery on his left pinkie finger and is out indefinitely.','2024-04-15'),
	 ('Chris Boucher','Toronto Raptors','TOR','Knee','Out','Raptors head coach Darko Rajakovic said Boucher is dealing with MCL tear in his right knee and is likely out the next 6-8 weeks.','2024-04-15'),
	 ('Scottie Barnes','Toronto Raptors','TOR','Hand','Out','The Toronto Raptors announced that F Scottie Barnes has sustained a fracture to the third metacarpal bone of his left hand and is out indefinitely.','2024-04-15'),
	 ('Immanuel Quickley','Toronto Raptors','TOR','Adductor','Out','Quickley is OUT for Sunday''s (Apr. 14) game against Miami.','2024-04-15'),
	 ('Mouhamadou Gueye','Toronto Raptors','TOR','Thumb','Out','Gueye is OUT for Sunday''s (Apr. 14) game against Miami.','2024-04-15'),
	 ('D.J. Carton','Toronto Raptors','TOR','Ankle','Out','Carton is OUT for Sunday''s (Apr. 14) game against Miami.','2024-04-15');
INSERT INTO injuries (player,team,team_acronym,injury,injury_status,injury_description,scrape_date) VALUES
	 ('Derrick White','Boston Celtics','BOS','Ankle','Out','White is OUT for Sunday''s (Apr. 14) game against Washington.','2024-04-15'),
	 ('Jayson Tatum','Boston Celtics','BOS','Rest','Out','Tatum is OUT for Sunday''s (Apr. 14) game against Washington.','2024-04-15'),
	 ('Kristaps Porzingis','Boston Celtics','BOS','Rest','Out','Porzingis is OUT for Sunday''s (Apr. 14) game against Washington.','2024-04-15'),
	 ('Al Horford','Boston Celtics','BOS','Rest','Out','Horford is OUT for Sunday''s (Apr. 14) game against Washington.','2024-04-15'),
	 ('Jrue Holiday','Boston Celtics','BOS','Knee','Out','Holiday is OUT for Sunday''s (Apr. 14) game against Washington.','2024-04-15'),
	 ('Jaylen Brown','Boston Celtics','BOS','Rest','Out','Brown is OUT for Sunday''s (Apr. 14) game against Washington.','2024-04-15'),
	 ('Bennedict Mathurin','Indiana Pacers','IND','Shoulder','Out For Season','The Pacers announced that Mathurin will miss the rest of the season after undergoing shoulder surgery.','2024-04-15'),
	 ('Josh Richardson','Miami Heat','MIA','Shoulder','Out For Season','The Heat announced that Richardson underwent right shoulder surgery and will miss the remainder of the season.','2024-04-15'),
	 ('Terry Rozier','Miami Heat','MIA','Neck','Out','Rozier is OUT for Sunday''s (Apr. 14) game against Toronto.','2024-04-15'),
	 ('Duncan Robinson','Miami Heat','MIA','Facet','Out','Robinson is OUT for Sunday''s (Apr. 14) game against Toronto.','2024-04-15');
INSERT INTO injuries (player,team,team_acronym,injury,injury_status,injury_description,scrape_date) VALUES
	 ('De''Anthony Melton','Philadelphia 76ers','PHI','Back','Out','Melton is OUT for Sunday''s (Apr. 14) game against Brooklyn.','2024-04-15'),
	 ('KJ Martin','Philadelphia 76ers','PHI','Toe','Out','Martin is OUT for Sunday''s (Apr. 14) game against Brooklyn.','2024-04-15'),
	 ('Joel Embiid','Philadelphia 76ers','PHI','Knee','Out','Embiid is OUT for Sunday''s (Apr. 14) game against Brooklyn.','2024-04-15'),
	 ('Robert Covington','Philadelphia 76ers','PHI','Knee','Out','Covington last played (Dec. 30), and has no timetable on his return.','2024-04-15'),
	 ('Keita Bates-Diop','Brooklyn Nets','BKN','Shin','Out For Season','The Nets announced Bates-Diop will miss the remainder of the season after under going a procedure to address a stress fracture.','2024-04-15'),
	 ('Dennis Smith','Brooklyn Nets','BKN','Hip','Out','Smith Jr. is OUT for Sunday''s (Apr. 14) game against Philadelphia.','2024-04-15'),
	 ('Day''Ron Sharpe','Brooklyn Nets','BKN','Wrist','Out','Sharpe is OUT for Sunday''s (Apr. 14) game against Philadelphia.','2024-04-15'),
	 ('Jaylen Martin','Brooklyn Nets','BKN','Ankle','Out','Martin is OUT for Sunday''s (Apr. 14) game against Philadelphia.','2024-04-15'),
	 ('Dorian Finney-Smith','Brooklyn Nets','BKN','Knee','Out','Finney-Smith is OUT for Sunday''s (Apr. 14) game against Philadelphia.','2024-04-15'),
	 ('Cameron Johnson','Brooklyn Nets','BKN','Toe','Out','Johnson is OUT for Sunday''s (Apr. 14) game against Philadelphia.','2024-04-15');
INSERT INTO injuries (player,team,team_acronym,injury,injury_status,injury_description,scrape_date) VALUES
	 ('Ben Simmons','Brooklyn Nets','BKN','Back','Out For Season','The Nets announced that Simmons will miss the rest of the season with a nerve impingement in his lower back.','2024-04-15'),
	 ('Dariq Whitehead','Brooklyn Nets','BKN','Shin','Out For Season','Nets coach Jacque Vaughn said Whitehead will undergo season-ending surgery.','2024-04-15'),
	 ('LaMelo Ball','Charlotte Hornets','CHA','Ankle','Out For Season','Ball hasn''t played since Jan. 26 and will miss the remainder of the season as he continues rehab, per Senior lead NBA Insider Shams Charania.','2024-04-15'),
	 ('Seth Curry','Charlotte Hornets','CHA','Ankle','Out','Curry is still OUT with an ankle injury with no update on a return.','2024-04-15'),
	 ('Cody Martin','Charlotte Hornets','CHA','Ankle','Out','Martin is still OUT with an ankle injury and has no timetable on a return.','2024-04-15'),
	 ('Grant Williams','Charlotte Hornets','CHA','Ankle','Out','Williams is OUT for Sunday''s (Apr. 14) game against Cleveland.','2024-04-15'),
	 ('Nick Richards','Charlotte Hornets','CHA','Foot','Out','Richards is OUT for Sunday''s (Apr. 14) game against Cleveland.','2024-04-15'),
	 ('Brandon Miller','Charlotte Hornets','CHA','Wrist','Out','Miller is OUT for Sunday''s (Apr. 14) game against Cleveland.','2024-04-15'),
	 ('Miles Bridges','Charlotte Hornets','CHA','Wrist','Out','Bridges is OUT for Sunday''s (Apr. 14) game against Cleveland.','2024-04-15'),
	 ('Davis Bertans','Charlotte Hornets','CHA','Achilles','Out','Bertans is OUT for Sunday''s (Apr. 14) game against Cleveland.','2024-04-15');
INSERT INTO injuries (player,team,team_acronym,injury,injury_status,injury_description,scrape_date) VALUES
	 ('Mark Williams','Charlotte Hornets','CHA','Back','Out','Williams hasn''t played since Dec. 8 against Toronto and remains without a timetable to return.','2024-04-15'),
	 ('Bilal Coulibaly','Washington Wizards','WAS','Wrist','Out For Season','Wizard announced Coulibaly will miss the remainder of the regular season after being diagnosed with a right wrist fracture.','2024-04-15'),
	 ('Tristan Vukcevic','Washington Wizards','WAS','Ankle','Out','Vukcevic is OUT for Sunday''s (Apr. 14) game against Boston.','2024-04-15'),
	 ('Landry Shamet','Washington Wizards','WAS','Calf','Out','Shamet is out for Sunday''s (Apr. 14) game against Boston.','2024-04-15'),
	 ('Jordan Poole','Washington Wizards','WAS','Illness','Out','Poole is OUT for Sunday''s (Apr. 14) game against Boston.','2024-04-15'),
	 ('Kyle Kuzma','Washington Wizards','WAS','Ankle','Out','Kuzmai is out for Sunday''s (Apr. 14) game against Boston.','2024-04-15'),
	 ('Richaun Holmes','Washington Wizards','WAS','Toe','Out','Holmes is OUT for Sunday''s (Apr. 14) game against Boston.','2024-04-15'),
	 ('Marvin Bagley','Washington Wizards','WAS','Knee','Out','Bagley III is out for Sunday''s (Apr. 14) game against Boston.','2024-04-15'),
	 ('Tyus Jones','Washington Wizards','WAS','Back','Out','Jones is out for Sunday''s (Apr. 14) game against Boston.','2024-04-15'),
	 ('Ayo Dosunmu','Chicago Bulls','CHI','Quad','Out','Dosunmu is OUT for Sunday''s (Apr. 14) game against New York.','2024-04-15');
INSERT INTO injuries (player,team,team_acronym,injury,injury_status,injury_description,scrape_date) VALUES
	 ('Julian Phillips','Chicago Bulls','CHI','Foot','Out','Phillips is OUT for Sunday''s (Apr. 14) game against New York.','2024-04-15'),
	 ('Andre Drummond','Chicago Bulls','CHI','Quadricep','Out','Drummond is OUT for Sunday''s (Apr. 14) game against New York.','2024-04-15'),
	 ('Alex Caruso','Chicago Bulls','CHI','Ankle','Out','Caruso is OUT for Sunday''s (Apr. 13) game against New York.','2024-04-15'),
	 ('Patrick Williams','Chicago Bulls','CHI','Foot','Out For Season','The Bulls announced that Williams will undergo season ending foot surgery.','2024-04-15'),
	 ('Zach LaVine','Chicago Bulls','CHI','Ankle','Out For Season','The Chicago Bulls announced guard Zach LaVine will undergo surgery on right foot and be out the rest of the season. via @AdamSchefter on X.','2024-04-15'),
	 ('Lonzo Ball','Chicago Bulls','CHI','Knee','Out For Season','Ball will miss the 2023-24 season while recovering from surgery.','2024-04-15'),
	 ('Julius Randle','New York Knicks','NYK','Shoulder','Out For Season','The Knicks announced that Randle will undergo surgery on his right shoulder and will be re-evaluated in five months.','2024-04-15'),
	 ('Quentin Grimes','Detroit Pistons','DET','Knee','Out For Season','Grimes will miss the rest of the season to rehab lingering muscle soreness related to his knee injury, according to Shams Charani.','2024-04-15'),
	 ('Stanley Umude','Detroit Pistons','DET','Ankle','Out For Season','Umude is expected to miss the rest of the season with a hairline fracture to the right ankle.','2024-04-15'),
	 ('Ausar Thompson','Detroit Pistons','DET','Illness','Out For Season','The Pistons announced that Thompson will miss the rest of the season while being treated for a blood clot.','2024-04-15');
INSERT INTO injuries (player,team,team_acronym,injury,injury_status,injury_description,scrape_date) VALUES
	 ('Isaiah Stewart','Detroit Pistons','DET','Hamstring','Out For Season','The Pistons announced that Stewart will miss the rest of the season with a right hamstring strain.','2024-04-15'),
	 ('Simone Fontecchio','Detroit Pistons','DET','Toe','Out','Fontecchio is out for Sunday''s (Apr. 14) game against San Antonio.','2024-04-15'),
	 ('Jalen Duren','Detroit Pistons','DET','Back','Out','Duren is OUT for Sunday''s (Apr. 14) game against San Antonio.','2024-04-15'),
	 ('Cade Cunningham','Detroit Pistons','DET','Knee','Out','Cunningham is OUT for Sunday''s (Apr. 14) game against San Antonio.','2024-04-15'),
	 ('Saddiq Bey','Atlanta Hawks','ATL','Knee','Out For Season','The Atlanta Hawks announced Saddiq Bey underwent successful surgery Wednesday (Mar. 27) to repair the torn left anterior cruciate ligament (ACL) in his left knee.','2024-04-15'),
	 ('Onyeka Okongwu','Atlanta Hawks','ATL','Toe','Out','Okongwu (left big toe sprain) underwent a non-surgical procedure and will be re-evaluated in 4 weeks.','2024-04-15'),
	 ('Wesley Matthews','Atlanta Hawks','ATL','Hamstring','Out','Matthews is OUT for Sunday''s (Apr. 14) game against Indiana.','2024-04-15'),
	 ('Seth Lundy','Atlanta Hawks','ATL','Ankle','Out','Lundy is OUT for Sunday''s (Apr. 14) game against Indiana.','2024-04-15'),
	 ('Jalen Johnson','Atlanta Hawks','ATL','Ankle','Out','Johnson suffered a level 2 ankle sprain and will be re-evaluated in 3 weeks.','2024-04-15'),
	 ('Clint Capela','Atlanta Hawks','ATL','Rest','Out','Capela is OUT for Sunday''s (Apr. 14) game against Indiana.','2024-04-15');
INSERT INTO injuries (player,team,team_acronym,injury,injury_status,injury_description,scrape_date) VALUES
	 ('Ty Jerome','Cleveland Cavaliers','CLE','Ankle','Out','Jerome underwent surgery on his right ankle (Jan. 23) and remains out indefinitely.','2024-04-15'),
	 ('Darius Garland','Cleveland Cavaliers','CLE','Back','Out','Garland is OUT for Sunday''s (Apr. 14) game against Charlotte.','2024-04-15'),
	 ('Dean Wade','Cleveland Cavaliers','CLE','Knee','Out','Wade is OUT for Sunday''s (Apr. 14) game against Charlotte.','2024-04-15'),
	 ('Donovan Mitchell','Cleveland Cavaliers','CLE','Knee','Out','Mitchell is OUT for Sunday''s (Apr. 14) game against Charlotte.','2024-04-15'),
	 ('Sam Merrill','Cleveland Cavaliers','CLE','Neck','Out','Merrill is OUT for Sunday''s (Apr. 14) game against Charlotte.','2024-04-15'),
	 ('Christian Wood','Los Angeles Lakers','LAL','Knee','Out','Wood will undergo an arthroscopic procedure on his left knee and is expected to be sidelined for several weeks. via @Woj','2024-04-15'),
	 ('Jarred Vanderbilt','Los Angeles Lakers','LAL','Foot','Out','Vanderbilt (foot) is progressing in his rehab, but he has not been cleared for on-court activities as of Tuesday, Khobi Price of The Orange County Register reports.','2024-04-15'),
	 ('Jalen Hood-Schifino','Los Angeles Lakers','LAL','Back','Out','Lakers say Jalen Hood-Schifino underwent a lumbar microdiscectomy back procedure today. No timetable on return.','2024-04-15'),
	 ('Kawhi Leonard','Los Angeles Clippers','LAC','Knee','Out','Leonard is out for Sunday''s (Apr. 14) game against Houston.','2024-04-15'),
	 ('James Harden','Los Angeles Clippers','LAC','Foot','Out','Harden is OUT for Sunday''s (Apr. 14) game against Houston.','2024-04-15');
INSERT INTO injuries (player,team,team_acronym,injury,injury_status,injury_description,scrape_date) VALUES
	 ('Collin Gillespie','Denver Nuggets','DEN','Knee','Out','Gillespie is OUT for Sunday''s (Apr. 14) game against Memphis.','2024-04-15'),
	 ('Vlatko Cancar','Denver Nuggets','DEN','Knee','Out','The Nuggets announced that Cancar underwent surgery on his left knee and is out indefinitely.','2024-04-15'),
	 ('Alperen Sengun','Houston Rockets','HOU','Ankle','Out','Sengun has been diagnosed with a Grade 3 sprain and will likely miss the rest of the season. via Shams Charania','2024-04-15'),
	 ('Fred VanVleet','Houston Rockets','HOU','Hip','Out','VanVleet is out for Sunday''s (Apr. 14) game against the Clippers.','2024-04-15'),
	 ('Jae''Sean Tate','Houston Rockets','HOU','Ankle','Out','Tate is out for Sunday''s (Apr. 14) game against the Clippers.','2024-04-15'),
	 ('Tari Eason','Houston Rockets','HOU','Leg','Out For Season','Rockets coach Ime Udoka announced that Eason will undergo season-ending surgery.','2024-04-15'),
	 ('Dillon Brooks','Houston Rockets','HOU','Abductor','Out','Brooks is out for Sunday''s (Apr. 14) game against the Clippers.','2024-04-15'),
	 ('Steven Adams','Houston Rockets','HOU','Knee','Out For Season','The Grizzlies announced that Adams will undergo season-ending surgery on his right knee.','2024-04-15'),
	 ('Lauri Markkanen','Utah Jazz','UTA','Shoulder','Out','The Jazz announced that Markkanen re-aggravated his shoulder impingement and will be re-evaluated in two weeks.','2024-04-15'),
	 ('Collin Sexton','Utah Jazz','UTA','Illness','Out','Sexton is OUT for Sunday''s (Apr. 14) game against Golden State.','2024-04-15');
INSERT INTO injuries (player,team,team_acronym,injury,injury_status,injury_description,scrape_date) VALUES
	 ('Walker Kessler','Utah Jazz','UTA','Nose','Out','Kessler is out for Sunday''s (Apr. 14) game against Golden State.','2024-04-15'),
	 ('Kris Dunn','Utah Jazz','UTA','Foot','Out','Dunn is out for Sunday''s (Apr. 14) game against Golden State.','2024-04-15'),
	 ('John Collins','Utah Jazz','UTA','Back','Out','Collins is out for Sunday''s (Apr. 14) game against Golden State.','2024-04-15'),
	 ('Jordan Clarkson','Utah Jazz','UTA','Back','Out','Clarkson is out for Sunday''s (Apr. 14) game against Golden State.','2024-04-15'),
	 ('P.J. Washington','Dallas Mavericks','DAL','Ankle','Out','Washington Jr. is out for Sunday''s (Apr. 14) game against Oklahoma City.','2024-04-15'),
	 ('Dereck Lively','Dallas Mavericks','DAL','Knee','Out','Lively II is out for Sunday''s (Apr. 14) game against Oklahoma City.','2024-04-15'),
	 ('Maxi Kleber','Dallas Mavericks','DAL','Back','Out','Kleber is out for Sunday''s (Apr. 14) game against Oklahoma City.','2024-04-15'),
	 ('Derrick Jones','Dallas Mavericks','DAL','Shoulder','Out','Jones Jr. is out for Sunday''s (Apr. 14) game against Oklahoma City.','2024-04-15'),
	 ('Kyrie Irving','Dallas Mavericks','DAL','Hamstring','Out','Irving is out for Sunday''s (Apr. 14) game against Oklahoma City.','2024-04-15'),
	 ('Daniel Gafford','Dallas Mavericks','DAL','Elbow','Out','Gafford is out for Sunday''s (Apr. 14) game against Oklahoma City.','2024-04-15');
INSERT INTO injuries (player,team,team_acronym,injury,injury_status,injury_description,scrape_date) VALUES
	 ('Dante Exum','Dallas Mavericks','DAL','Foot','Out','Exum is out for Sunday''s (Apr. 14) game against Oklahoma City.','2024-04-15'),
	 ('Luka Doncic','Dallas Mavericks','DAL','Ankle','Out','Doncic is out for Sunday''s (Apr. 14) game against Oklahoma City.','2024-04-15'),
	 ('Greg Brown','Dallas Mavericks','DAL','Personal','Out','Brown III is out for Sunday''s (Apr. 14) game against Oklahoma City.','2024-04-15'),
	 ('Jabari Walker','Portland Trail Blazers','POR','Knee','Out','Walker is OUT for Sunday''s (Apr. 14) game against Sacramento.','2024-04-15'),
	 ('Matisse Thybulle','Portland Trail Blazers','POR','Ankle','Out','Thybulle is out for Sunday''s (Apr. 14) game against Sacramento.','2024-04-15'),
	 ('Anfernee Simons','Portland Trail Blazers','POR','Knee','Out','Simons is OUT for Sunday''s (Apr. 14) game against Sacramento.','2024-04-15'),
	 ('Shaedon Sharpe','Portland Trail Blazers','POR','Abdomen','Out','Sharpe is out for Sunday''s (Apr. 14) game against Sacramento.','2024-04-15'),
	 ('Scoot Henderson','Portland Trail Blazers','POR','Hip','Out','Henderson is OUT for Sunday''s (Apr. 14) game against Sacramento.','2024-04-15'),
	 ('Jerami Grant','Portland Trail Blazers','POR','Hamstring','Out','Grant is out for Sunday''s (Apr. 14) game against Sacramento.','2024-04-15'),
	 ('Deandre Ayton','Portland Trail Blazers','POR','Back','Out','Ayton is OUT for Sunday''s (Apr. 14) game against Sacramento.','2024-04-15');
INSERT INTO injuries (player,team,team_acronym,injury,injury_status,injury_description,scrape_date) VALUES
	 ('Toumani Camara','Portland Trail Blazers','POR','Rib','Out For Season','Camara is OUT for the rest of the season but will make a full recovery from his rib fracture.','2024-04-15'),
	 ('Malcolm Brogdon','Portland Trail Blazers','POR','Elbow','Out','The Trail Blazers announced that Brogdon has increased his workload in workouts and is trending in the right direction, but there is no clear timetable on his return.','2024-04-15'),
	 ('Robert Williams','Portland Trail Blazers','POR','Knee','Out For Season','Williams III will be required to undergo season-ending knee surgery, per Adrian Wojnarowski.','2024-04-15'),
	 ('Ziaire Williams','Memphis Grizzlies','MEM','Hip','Out','The Memphis Grizzlies announced Williams is diagnosed with a grad2 strain of the hip and back and will be evaluated in four weeks.','2024-04-15'),
	 ('Derrick Rose','Memphis Grizzlies','MEM','Back','Out','The Memphis Grizzlies announced Rose was diagnosed with osteitis pubis and will be re-evaluated in three weeks.','2024-04-15'),
	 ('Vince Williams','Memphis Grizzlies','MEM','Knee','Out','Williams Jr. is out for Sunday''s (Apr. 14) game against Denver.','2024-04-15'),
	 ('Yuta Watanabe','Memphis Grizzlies','MEM','Personal','Out','Watanabe is out for Sunday''s (Apr. 14) game against Denver.','2024-04-15'),
	 ('Lamar Stevens','Memphis Grizzlies','MEM','Groin','Out','Stevens is out for Sunday''s (Apr. 14) game against Denver.','2024-04-15'),
	 ('John Konchar','Memphis Grizzlies','MEM','Heel','Out','Konchar is out for Sunday''s (Apr. 14) game against Denver.','2024-04-15'),
	 ('Luke Kennard','Memphis Grizzlies','MEM','Knee','Out','Kennard is out for Sunday''s (Apr. 14) game against Denver.','2024-04-15');
INSERT INTO injuries (player,team,team_acronym,injury,injury_status,injury_description,scrape_date) VALUES
	 ('Jaren Jackson','Memphis Grizzlies','MEM','Quad','Out','Jackson Jr. is out for Sunday''s (Apr. 14) game against Denver.','2024-04-15'),
	 ('Brandon Clarke','Memphis Grizzlies','MEM','Hand','Out','Clarke is out for Sunday''s (Apr. 14) game against Denver.','2024-04-15'),
	 ('Desmond Bane','Memphis Grizzlies','MEM','Back','Out','Bane is out for Sunday''s (Apr. 14) game against Denver.','2024-04-15'),
	 ('Santi Aldama','Memphis Grizzlies','MEM','Foot','Out','Aldama is out for Sunday''s (Apr. 14) game against Denver.','2024-04-15'),
	 ('Marcus Smart','Memphis Grizzlies','MEM','Finger','Out','The Grizzlies announced that Smart''s injury is healing properly and he will be re-evaluated in three weeks.','2024-04-15'),
	 ('Ja Morant','Memphis Grizzlies','MEM','Shoulder','Out For Season','Grizzlies announced Ja Morant will undergo season-ending surgery on his shoulder.','2024-04-15'),
	 ('Eric Gordon','Phoenix Suns','PHX','Migrane','Day To Day','Gordon is OUT for Sunday''s (Apr. 14) game against Minnesota.','2024-04-15'),
	 ('Damion Lee','Phoenix Suns','PHX','Knee','Out','Head coach Frank Vogel said Monday that Lee (knee) has yet to resume on-court work, but the Suns remain hopeful that the 31-year-old will play before the end of the regular season, Duane Rankin of The Arizona Republic reports.','2024-04-15'),
	 ('Devin Vassell','San Antonio Spurs','SAS','Foot','Out For Season','Spurs announced Vassell is out for the rest of the season with a foot injury.','2024-04-15'),
	 ('Jeremy Sochan','San Antonio Spurs','SAS','Ankle','Out For Season','Spurs announced Sochan is out for the rest of the season with an ankle injury.','2024-04-15');
INSERT INTO injuries (player,team,team_acronym,injury,injury_status,injury_description,scrape_date) VALUES
	 ('Victor Wembanyama','San Antonio Spurs','SAS','Ankle','Out','Wembanyama is out for Sunday''s (Apr. 14) game against Detroit.','2024-04-15'),
	 ('Cedi Osman','San Antonio Spurs','SAS','Ankle','Out','Osman is out for Sunday''s (Apr. 14) game against Detroit.','2024-04-15'),
	 ('Keldon Johnson','San Antonio Spurs','SAS','Foot','Out','Johnson is out for Sunday''s (Apr. 14) game against Detroit.','2024-04-15'),
	 ('Malaki Branham','San Antonio Spurs','SAS','Concussion','Out','Branham is out for Sunday''s (Apr. 14) game against Detroit.','2024-04-15'),
	 ('Dominick Barlow','San Antonio Spurs','SAS','Knee','Out','Barlow is out for Sunday''s (Apr. 14) game against Detroit.','2024-04-15'),
	 ('Charles Bassey','San Antonio Spurs','SAS','Knee','Out For Season','The San Antonio Spurs announced C Charles Bassey is out for the season with a torn ACL.','2024-04-15'),
	 ('Malik Monk','Sacramento Kings','SAC','MCL Sprain','Out','Monk suffered a sprained right MCL and is expected to miss four-to-six weeks.','2024-04-15'),
	 ('Kevin Huerter','Sacramento Kings','SAC','Shoulder','Out For Season','Huerter will have season-ending left shoulder surgery. Huerter is expected to be recovered for the start of the 2024-25 season.','2024-04-15'),
	 ('Jaylen Clark','Minnesota Timberwolves','MIN','Achilles','Out','Clark still remains out due to an achilles injury, and has no timetable for return.','2024-04-15'),
	 ('Gary Payton','Golden State Warriors','GSW','Calf','Out','Payton II is out for Sunday''s (Apr. 14) game against Utah.','2024-04-15');
INSERT INTO injuries (player,team,team_acronym,injury,injury_status,injury_description,scrape_date) VALUES
	 ('Draymond Green','Golden State Warriors','GSW','Knee','Out','Green is OUT for Sunday''s (Apr. 14) game against Utah.','2024-04-15'),
	 ('Stephen Curry','Golden State Warriors','GSW','Ankle','Out','Curry is OUT for Sunday''s (Apr. 14) game against Utah.','2024-04-15');


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

DROP TABLE IF EXISTS team_game_types;
CREATE TABLE team_game_types(
	team varchar,
    game_type text,
    season_type text,
    n bigint,
    explanation text
);

INSERT INTO team_game_types (team, game_type, season_type, n, explanation)
VALUES ('IND', '20 pt Game', 'Regular Season', 30, 'between 11 and 20 points'),
       ('IND', 'Blowout Game', 'Regular Season', 30, 'more than 20 points'),
       ('IND', '10 pt Game', 'Regular Season', 10, 'between 6 and 10 points'),
       ('IND', 'Clutch Game', 'Regular Season', 12, '5 points or less');


DROP TABLE IF EXISTS feedback;
CREATE TABLE feedback(
    id serial primary key,
    feedback character varying,
	created_at timestamp default now(),
	modified_at timestamp default now()
);

INSERT INTO feedback (feedback)
VALUES
	('I love this site!'),
	('This site is terrible!'),
	('I have no opinion on this site.'),
	('I have a suggestion for this site.'),
	('I have a complaint about this site.'),
	('I have a question about this site.');

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
       (current_date, 'Monday', 20, '7:00 PM', 'New York Knicks', 'Indiana Pacers', -365, 300),
       (current_date - interval '1 day', 'Sunday', 4, '7:00 PM', 'Philadelphia 76ers', 'Milwaukee Bucks', -125, 110),
       (current_date - interval '1 day', 'Sunday', 13, '7:00 PM', 'Golden State Warriors', 'Miami Heat', -140, 130),
       ('2023-01-01', 'Sunday', 4, '7:00 PM', 'Atlanta Hawks', 'Indiana Pacers', -150, 140);

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
	role varchar default 'Consumer',
    created_at timestamp default now(),
	modified_at timestamp default now(),
	timezone varchar default 'UTC'
);

-- these users all have password as the actual "password"
INSERT INTO rest_api_users(username, password, salt, email, role)
VALUES ('jyablonski', 'db15bf237233df6654f39476884e8bb9', 'eylptjzw6tqy68zxg5b8v9l2bdwxsztf', 'j@yablonski.com', 'Admin'),
       ('test', '0b1bcb3aa21cc0325ccfec50ae77ee09', 'utwvsvfcofpanwtwt7u3tegwvnz5ey35', 'test@nobody.com', 'Consumer'),
       ('test1', 'fc69b839fbcd8ecd2d9407406a9eec66', 'u61hred56dm6il2sgtws9m1k4704y3ph', 'test@nobody.com', 'Admin'),
       ('test2', '32b67f6dad97c4d009bab26dfbafbe27', 'cxfpyjvny5kro6phuxpchxlxg1c1stjw', 'test@nobody.com', 'Consumer'),
       ('test3', '6c4dab6f6c721e9eb0ed908e8b7f7a06', 'lv1exd0c2tmfv414voo1716ggrpnk60f', 'test@nobody.com', 'Consumer');


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
       ('playoffs', 1),
	   ('gmail_oauth_login_form', 0);

create view user_past_predictions as
WITH home_wins AS (
    SELECT
        mov.full_team AS home_team,
        mov.game_date,
        mov.outcome
    FROM marts.mov
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
    FROM marts.user_predictions
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

DROP TABLE IF EXISTS reports;
CREATE TABLE IF NOT EXISTS reports
(
	id serial primary key,
	report_name varchar(40) not null,
	is_active integer not null default 1,
	created_at timestamp default current_timestamp,
	modified_at timestamp default current_timestamp
);

INSERT INTO reports(report_name, is_active)
VALUES ('User Predictions History', 1),
	   ('Most Profitable Bets', 1),
	   ('Least Profitable Bets', 1);

DROP TABLE IF EXISTS team_event_context;
CREATE TABLE IF NOT EXISTS team_event_context
(
	id serial primary key,
	team char(3) not null,
	event varchar(300) not null,
	event_date date not null,
	created_at timestamp default current_timestamp,
	modified_at timestamp default current_timestamp
);

INSERT INTO team_event_context(team, event, event_date)
VALUES
	('GSW', 'Lost the Play-In Game vs Sacramento Kings', '2024-04-16'),
	('GSW', 'Statement Win vs Phoenix Suns', '2024-02-10');
