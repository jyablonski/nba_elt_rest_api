import json

import pytest
import pytest_mock

def test_standings(standings_fixture):
    assert len(standings_fixture) == 30

def test_game_types(game_types_fixture):
    assert len(game_types_fixture) == 8
    assert list(game_types_fixture[0].keys()) == ['game_type', 'type', 'n', 'explanation']

def test_injuries(injuries_fixture):
    assert list(injuries_fixture[0].keys()) == ['player', 'team_acronym', 'team', 'date', 'status', 'injury', 'description', 'total_injuries', 'team_active_injuries', 'team_active_protocols']

def test_injuries_single(injuries_team_fixture):
    assert list(injuries_team_fixture.keys()) == ['player', 'team_acronym', 'team', 'date', 'status', 'injury', 'description', 'total_injuries', 'team_active_injuries', 'team_active_protocols']

def test_team_ratings(team_ratings_fixture):
    assert list(team_ratings_fixture[0].keys()) == ['team', 'team_acronym', 'w', 'l', 'ortg', 'drtg', 'nrtg', 'team_logo', 'nrtg_rank', 'drtg_rank', 'ortg_rank']

def test_team_ratings_single(team_ratings_team_fixture):
    assert list(team_ratings_team_fixture.keys()) == ['team', 'team_acronym', 'w', 'l', 'ortg', 'drtg', 'nrtg', 'team_logo', 'nrtg_rank', 'drtg_rank', 'ortg_rank']

def test_scorers(scorers_fixture):
    assert list(scorers_fixture[0].keys()) == ['player', 'team', 'full_team', 'season_avg_ppg', 'playoffs_avg_ppg', 'season_ts_percent', 'playoffs_ts_percent', 'games_played', 'playoffs_games_played', 'ppg_rank', 'top20_scorers', 'player_mvp_calc_adj', 'games_missed', 'penalized_games_missed', 'top5_candidates', 'mvp_rank']

def test_reddit_comments(reddit_comments_fixture):
    assert list(reddit_comments_fixture[0].keys()) == ['scrape_date', 'author', 'comment', 'flair', 'score', 'url', 'compound', 'neg', 'neu', 'pos']

def test_twitter_comments(twitter_comments_fixture):
    assert list(twitter_comments_fixture[0].keys()) == ['scrape_ts', 'username', 'tweet', 'url', 'likes', 'retweets', 'compound', 'neg', 'neu', 'pos']