# REST API for NBA ELT Project
![Tests](https://github.com/jyablonski/nba_elt_rest_api/actions/workflows/test.yaml/badge.svg) ![Deployment](https://github.com/jyablonski/nba_elt_rest_api/actions/workflows/deploy.yaml/badge.svg) [![Coverage Status](https://coveralls.io/repos/github/jyablonski/nba_elt_rest_api/badge.svg?branch=master)](https://coveralls.io/github/jyablonski/nba_elt_rest_api?branch=master) ![Code Style](https://img.shields.io/badge/code%20style-black-000000.svg)

Version: 1.11.0

## About the Project

The REST API has the following functionalities:
- Serves Data built from the NBA ELT Pipeline through various GET endpoints
- Hosts a user-facing Frontend that Allows people to login & make NBA Game Win Predictions and Betting
- Hosts an Internal Admin Frontend w/ various pages to manage things like Feature Flags and other functionality used throughout the project

The Project uses:
- A Postgres Database for the backend
- A Redis Database to enable caching across various endpoints to improve performance
- JWT for Authentication and Authorization

## Running The App
Clone the Repo & run `make up` which spins up the App locally served [here](http://localhost:8080/) using 3 Docker Containers:
- Postgres Database
- Redis Database
- FastAPI Server

To Login to the App locally, a set of Credentials for an Admin User are listed below:
- Username: `test1`
- Password: `password`

When finished run `make down` to spin resources down.

## Tests
To run tests locally, run `make test`.

The same Test Suite is ran after every commit on a PR via GitHub Actions.

## Project
![nba_pipeline_diagram](https://github.com/jyablonski/nba_elt_rest_api/assets/16946556/12d00fcf-1d5a-4ced-a392-b7a8de239ff2)

1. Links to other Repos providing infrastructure for this Project
    * [Dash Server](https://github.com/jyablonski/nba_elt_dashboard)
    * [Ingestion Script](https://github.com/jyablonski/nba_elt_ingestion)
    * [dbt](https://github.com/jyablonski/nba_elt_dbt)
    * [Terraform](https://github.com/jyablonski/aws_terraform)
    * [ML Pipeline](https://github.com/jyablonski/nba_elt_mlflow)
    * [Interal Documentation](https://github.com/jyablonski/doqs)
