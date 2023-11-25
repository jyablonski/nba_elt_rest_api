import csv
from datetime import date
import hashlib
import io
import random
import string

from fastapi.templating import Jinja2Templates

from src.models import UserPastPredictions

templates = Jinja2Templates(directory="templates")

team_acronyms = [
    "ATL",
    "BKN",
    "BOS",
    "CHA",
    "CHI",
    "CLE",
    "DAL",
    "DEN",
    "DET",
    "GSW",
    "HOU",
    "IND",
    "LAC",
    "LAL",
    "MEM",
    "MIA",
    "MIN",
    "MIL",
    "NOP",
    "NYK",
    "OKC",
    "ORL",
    "PHI",
    "PHX",
    "POR",
    "SAC",
    "SAS",
    "TOR",
    "UTA",
    "WAS",
]


def generate_salt(size: int = 32) -> str:
    chars = string.ascii_lowercase + string.digits
    salt = "".join(random.choice(chars) for _ in range(size))

    return salt


def generate_hash_password(password: str, salt: str) -> str:
    hash_password = hashlib.md5((password + salt).encode("utf-8")).hexdigest()

    return hash_password


# avoiding pandas
def generate_csv(
    sqlalchemy_query: list[UserPastPredictions], headers: list[str], report_date: date
) -> str:
    output = io.StringIO()
    writer = csv.writer(output)

    file_headers = headers.copy()
    file_headers.append("report_pull_date")
    writer.writerow(file_headers)

    for row in sqlalchemy_query:
        data_row = [getattr(row, column) for column in headers]
        data_row.append(report_date)
        writer.writerow(data_row)

    return output.getvalue()
