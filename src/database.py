import os
import yaml

from opentelemetry.instrumentation.sqlalchemy import SQLAlchemyInstrumentor
from sqlalchemy import create_engine, exc
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker


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


with open("config.yaml", "r") as config:
    env = yaml.safe_load(config)[os.environ.get("ENV_TYPE")]

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
