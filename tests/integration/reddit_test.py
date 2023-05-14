def test_reddit_comments(client_fixture):
    response = client_fixture.get("/reddit_comments")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 2
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
