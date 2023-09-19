from typing import List

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from src.dao.transactions import get_transactions
from src.database import get_db
from src.schemas import TransactionsBase

router = APIRouter()


@router.get("/transactions", response_model=List[TransactionsBase])
async def read_transactions(db: Session = Depends(get_db)):
    transactions = get_transactions(db)
    return transactions
