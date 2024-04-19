from sqlalchemy.orm import Session

from src.models import Reports


def get_reports(db: Session) -> list[Reports]:
    return db.query(Reports.report_name).all()
