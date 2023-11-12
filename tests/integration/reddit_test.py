def test_reddit_comments(client_fixture):
    response = client_fixture.get("/reddit_comments")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 4
    assert data[0]["author"] == "rattatatouille"
    assert list(data[0].keys()) == [
        "scrape_date",
        "author",
        "comment",
        "flair",
        "score",
        "url",
        "compound",
        "neg",
        "neu",
        "pos",
    ]


def test_reddit_comments_limit(client_fixture):
    response = client_fixture.get("/reddit_comments?limit=1")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 1
    assert data[0]["author"] == "rattatatouille"


def test_reddit_comments_filter(client_fixture):
    response = client_fixture.get("/reddit_comments?filter=jokic")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 1
    assert data[0]["author"] == "rattatatouille"


def test_reddit_comments_filter_case_insensitive(client_fixture):
    response = client_fixture.get("/reddit_comments?filter=nba")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 3
    assert data[0]["author"] == "KaiserKaiba"
    assert data[0]["comment"] == "NBA scriptwriters working overtime right now"


def test_reddit_comments_multiple_conditions(client_fixture):
    response = client_fixture.get("/reddit_comments?filter=nba&limit=2")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 2
    assert data[0]["author"] == "KaiserKaiba"
    assert data[0]["comment"] == "NBA scriptwriters working overtime right now"
