from sqlalchemy.orm import Session

from src.models.player_stats import PlayerStats


def get_player_stats(db: Session, skip: int = 0, limit=250) -> list[PlayerStats]:
    return db.query(PlayerStats).offset(skip).limit(limit).all()


def get_player_stats_by_team(
    db: Session, team: str, skip: int = 0, limit=250
) -> list[PlayerStats]:
    return (
        db.query(PlayerStats)
        .filter(PlayerStats.team == team)
        .offset(skip)
        .limit(limit)
        .all()
    )
