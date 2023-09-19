from datetime import datetime

from src.utils import generate_csv


def test_generate_csv():
    example_csv = generate_csv(
        sqlalchemy_query="",
        headers=["col1", "col2", "col3"],
        report_date=datetime.now().date(),
    )

    assert example_csv == "col1,col2,col3,report_pull_date\r\n"
