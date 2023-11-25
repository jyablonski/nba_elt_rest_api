from fastapi import APIRouter, Depends
from fastapi_cache.decorator import cache
from sqlalchemy.orm import Session

from src.cache import key_builder_no_db
from src.dao.transactions import get_transactions
from src.database import get_db
from src.schemas import TransactionsBase

router = APIRouter()


@router.get("/transactions", response_model=list[TransactionsBase])
@cache(expire=900, key_builder=key_builder_no_db)
async def read_transactions(db: Session = Depends(get_db)):
    transactions = get_transactions(db)
    return transactions
