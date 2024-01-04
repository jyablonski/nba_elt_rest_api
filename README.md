# REST API for NBA ELT Project
![Tests](https://github.com/jyablonski/nba_elt_rest_api/actions/workflows/test.yaml/badge.svg) ![Deployment](https://github.com/jyablonski/nba_elt_rest_api/actions/workflows/deploy.yaml/badge.svg) [![Coverage Status](https://coveralls.io/repos/github/jyablonski/nba_elt_rest_api/badge.svg?branch=master)](https://coveralls.io/github/jyablonski/nba_elt_rest_api?branch=master) ![Code Style](https://img.shields.io/badge/code%20style-black-000000.svg)

Version: 1.7.4

## [API](https://api.jyablonski.dev)

The REST API has the following functionalities:
- Serves Data built from the NBA ELT Pipeline through various GET endpoints
- Allows Users to login & make NBA Game Win Predictions starting from the [Login Web Page](https://api.jyablonski.dev/login)
- Hosts an Internal Admin Site w/ the following Pages:
  -  Page to flip Feature Flags on / off that are used in various components throughout the Project.
  -  Page to create incidents which will automatically popup on the Web Dashboard to alert users of any missing or out-of-date data issues.

## Running The App
Clone the Repo & run `make up` which spins up the App locally served [here](http://localhost:8080/) using 2 Docker Containers:
- Postgres Database
- FastAPI Server

If you wish to login to a User locally with bootstrapped data ready to go, a set of Credentials are listed below:
- Username: `test1`
- Password: `password`

When finished run `make down`.

## Tests
To run tests locally, run `make test`.

The same Test Suite is ran after every commit on a PR via GitHub Actions.

## Project
![nba_pipeline_diagram](https://github.com/jyablonski/nba_elt_rest_api/assets/16946556/12d00fcf-1d5a-4ced-a392-b7a8de239ff2)

1. Links to other Repos providing infrastructure for this Project
    * [Dash Server](https://github.com/jyablonski/nba_elt_dashboard)
    * [Ingestion Script](https://github.com/jyablonski/python_docker)
    * [dbt](https://github.com/jyablonski/nba_elt_dbt)
    * [Terraform](https://github.com/jyablonski/aws_terraform)
    * [ML Pipeline](https://github.com/jyablonski/nba_elt_mlflow)
