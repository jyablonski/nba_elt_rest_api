from fastapi import APIRouter, Depends
from fastapi_cache.decorator import cache
from sqlalchemy.orm import Session

from src.dao.transactions import get_transactions
from src.dependencies import get_db, key_builder_no_db
from src.schemas import TransactionsBase

router = APIRouter()


@router.get("/league/transactions", response_model=list[TransactionsBase])
@cache(expire=900, key_builder=key_builder_no_db)
async def read_transactions(db: Session = Depends(get_db)):
    transactions = get_transactions(db)
    return transactions
