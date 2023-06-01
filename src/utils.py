import hashlib
import random
import string

from fastapi.templating import Jinja2Templates

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
