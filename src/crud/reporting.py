from typing import Any

from sqlalchemy.orm import Session

from src.models.reporting import Reports


def get_reports(db: Session) -> list[Any]:
    return db.query(Reports.report_name).all()
