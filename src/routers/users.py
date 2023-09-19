from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from src.dao.users import create_user, delete_user, update_user
from src.database import get_db
from src.models import Users
from src.schemas import UserBase, UserCreate
from src.security import get_current_user_from_api_token

router = APIRouter()


@router.post("/users", response_model=UserCreate, status_code=201)
async def create_users(create_user_request: UserCreate, db: Session = Depends(get_db)):
    print(type(db))
    record_check = (
        db.query(Users).filter(Users.username == create_user_request.username).first()
    )

    if record_check:
        raise HTTPException(
            status_code=403,
            detail="Username already exists!  Please select another username.",
        )

    return create_user(db, create_user_request)


@router.put("/users/{username}", response_model=UserBase)
async def update_users(
    username: str, update_user_request: UserBase, db: Session = Depends(get_db)
):
    print(f"type db is {type(db)}")
    existing_user_record = db.query(Users).filter(Users.username == username).first()

    if not existing_user_record:
        raise HTTPException(
            status_code=404,
            detail="That old Username doesn't exist!  Please select another username.",
        )

    new_record_check = (
        db.query(Users).filter(Users.username == update_user_request.username).first()
    )

    if new_record_check:
        raise HTTPException(
            status_code=409,
            detail="The new requested Username already exists!  Please select another username.",
        )

    return update_user(db, existing_user_record, update_user_request)


@router.delete("/users/{username}")
def delete_users(
    username: str,
    token_user: str = Depends(get_current_user_from_api_token),
    db: Session = Depends(get_db),
):
    print(f"username in delete users endpoint is {username}")
    print(f"token user is delete users endpoint is {token_user}")
    if username != token_user:
        raise HTTPException(
            status_code=401,
            detail=f"{token_user} is not authenticated to perform this action on {username}",
            headers={"WWW-Authenticate": "Bearer"},
        )

    user_record = db.query(Users).filter(Users.username == username).first()

    return delete_user(db, user_record)
