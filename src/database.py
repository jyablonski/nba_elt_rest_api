from __future__ import annotations

import os
from typing import Any, TYPE_CHECKING
import yaml

from opentelemetry.instrumentation.sqlalchemy import SQLAlchemyInstrumentor
from sqlalchemy import create_engine, text
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

if TYPE_CHECKING:
    from sqlalchemy.engine import Engine
    from sqlalchemy.orm import Session


# pyyaml is fucking useless lmfao, how does this not come w/ the package ??????
def substitute_env_vars(yaml_content: dict[str, str]) -> None:
    for key, value in yaml_content.items():
        if isinstance(value, str):
            yaml_content[key] = os.path.expandvars(value)
        elif isinstance(value, dict):
            substitute_env_vars(value)


def load_yaml_with_env(filename: str) -> Any:
    with open(filename, "r") as file:
        yaml_content = yaml.safe_load(file)
        substitute_env_vars(yaml_content)
        return yaml_content


def sql_connection(
    user: str, password: str, host: str, database: str, schema: str, port: int = 5432
) -> Engine:
    """
    SQL Connection function connecting to my postgres db with a specific schema
    For REST API Project use `marts` for schema

    Args:
        user (str): Database User

        password (str): Database password

        host (str): Database Host IP

        database (str): Database to connect to

        schema (str): The Schema in the DB to connect to.

        port (int): Port to connect to the DB

    Returns:
        SQL Engine variable to a specified schema in the DB
    """
    connection = create_engine(
        f"postgresql+psycopg2://{user}:{password}@{host}:{port}/{database}",
        connect_args={"options": f"-csearch_path={schema}"},
        # defining schema to connect to
        echo=False,
    )
    print(f"SQL Engine created for {schema}")
    return connection


def run_query(query: str, session: Session) -> list[tuple]:
    """
    Small Wrapper Function to run Raw SQL Queries

    Args:
        query (str): The raw SQL query to be executed.
            (ex. select * from game_types limit 10)

        session (Session): The SQLAlchemy database session.

    Returns:
        list[tuple]: A list of tuples representing the query results.
    """
    result = session.execute(text(query))
    return result


# def get_db() -> Generator[Session, None, None]:
#     db = SessionLocal()
#     try:
#         yield db
#     finally:
#         db.close()


env = load_yaml_with_env("config.yaml")[os.environ.get("ENV_TYPE")]

engine = sql_connection(
    user=env["user"],
    password=env["pass"],
    host=env["host"],
    database=env["database"],
    schema=env["schema"],
    port=env["port"],
)
SQLAlchemyInstrumentor().instrument(engine=engine)

# separate database sessions for different users essentially.
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine, future=True)

Base = declarative_base()
