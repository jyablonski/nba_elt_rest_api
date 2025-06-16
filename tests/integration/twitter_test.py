def test_social_twitter_comments(client_fixture):
    response = client_fixture.get("/social/twitter/comments")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 2
    assert data[0]["username"] == "KingJames"
    assert list(data[0].keys()) == [
        "scrape_ts",
        "username",
        "tweet",
        "url",
        "likes",
        "retweets",
        "compound",
        "neg",
        "neu",
        "pos",
    ]
