import os
import yaml

from opentelemetry.instrumentation.sqlalchemy import SQLAlchemyInstrumentor
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker


# pyyaml is fucking useless lmfao, how does this not come w/ the package ??????
def substitute_env_vars(yaml_content: dict) -> None:
    for key, value in yaml_content.items():
        if isinstance(value, str):
            yaml_content[key] = os.path.expandvars(value)
        elif isinstance(value, dict):
            substitute_env_vars(value)


def load_yaml_with_env(filename: str) -> dict:
    with open(filename, "r") as file:
        yaml_content = yaml.safe_load(file)
        substitute_env_vars(yaml_content)
        return yaml_content


def sql_connection(user: str, password: str, host: str, database: str, schema: str):
    """
    SQL Connection function connecting to my postgres db with a specific schema
    For GraphQL Project use `nba_prod` for schema

    Args:
        user (str): Database User

        password (str): Database password

        host (str): Database Host IP

        database (str): Database to connect to

        schema (str): The Schema in the DB to connect to.

    Returns:
        SQL Engine variable to a specified schema in the DB
    """
    connection = create_engine(
        f"postgresql+psycopg2://{user}:{password}@{host}:5432/{database}",
        connect_args={"options": f"-csearch_path={schema}"},
        # defining schema to connect to
        echo=False,
    )
    print(f"SQL Engine created for {schema}")
    return connection


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


env = load_yaml_with_env("config.yaml")[os.environ.get("ENV_TYPE")]

engine = sql_connection(
    user=env["user"],
    password=env["pass"],
    host=env["host"],
    database=env["database"],
    schema=env["schema"],
)
SQLAlchemyInstrumentor().instrument(engine=engine)

# separate database sessions for different users essentially.
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine, future=True)

Base = declarative_base()
