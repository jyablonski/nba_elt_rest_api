def test_social_reddit_comments(client_fixture):
    response = client_fixture.get("social/reddit/comments")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 250
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


def test_social_reddit_comments_limit(client_fixture):
    response = client_fixture.get("social/reddit/comments?limit=1")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 1
    assert data[0]["author"] == "rattatatouille"


def test_social_reddit_comments_filter(client_fixture):
    response = client_fixture.get("social/reddit/comments?filter=jokic")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 3
    assert data[0]["author"] == "BowlWinHoosiers"


def test_social_reddit_comments_filter_case_insensitive(client_fixture):
    response = client_fixture.get("social/reddit/comments?filter=nba")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 54
    assert data[0]["author"] == "goingtothegreek"
    assert data[0]["comment"] == "I fine the NBA $50k for lying on the L2M, checkmate"


def test_social_reddit_comments_multiple_conditions(client_fixture):
    response = client_fixture.get("social/reddit/comments?filter=nba&limit=2")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 2
    assert data[0]["author"] == "goingtothegreek"
    assert data[0]["comment"] == "I fine the NBA $50k for lying on the L2M, checkmate"


def test_social_reddit_comments_pagination(client_fixture):
    response1 = client_fixture.get("social/reddit/comments?page=1&filter=as&limit=10")
    data1 = response1.json()

    response2 = client_fixture.get("social/reddit/comments?page=2&filter=as&limit=10")
    data2 = response2.json()

    assert response1.status_code == 200
    assert len(data1) == 10
    assert data1[0]["author"] == "MVPiid"
    assert (
        data1[0]["comment"]
        == "ngl i read this as these unnamed Sixers org people blaming Embiid for letting it get to him. Either way this isn't something the sixers should be putting out"
    )

    assert response2.status_code == 200
    assert len(data2) == 10
    assert data2[1]["author"] == "Pizzaplan3tman"
    assert (
        data2[1]["comment"]
        == "Reminds me of when LeBron set a pick for the Heat during a pre season game his second time back as a Cavalier. Was absolutely hilarious"
    )
