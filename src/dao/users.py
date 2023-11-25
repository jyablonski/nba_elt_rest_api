from fastapi.encoders import jsonable_encoder
from sqlalchemy.orm import Session

from src.models import Users
from src.schemas import UserBase, UserCreate
from src.utils import generate_hash_password, generate_salt


def create_user(db: Session, user: UserCreate):
    salt = generate_salt()

    password_hash = generate_hash_password(password=user.password, salt=salt)

    record = Users(
        username=user.username,
        password=password_hash,
        email=user.email,
        salt=salt,
        created_at=user.created_at,
    )

    db.add(record)
    db.commit()
    db.refresh(record)

    # return the password that the user presented in the form instead of the salted hash
    record.password = user.password
    return record


def update_user(db: Session, user_record: UserBase, update_user_request: UserBase):
    update_user_encoded = jsonable_encoder(update_user_request)
    user_record.username = update_user_encoded["username"]
    user_record.password = update_user_encoded["password"]
    user_record.email = update_user_encoded["email"]

    updated_user = db.merge(user_record)
    db.commit()
    return updated_user


def delete_user(db: Session, user_record: Users) -> str:
    db.delete(user_record)
    db.commit()
    return f"Username {user_record.username} Successfully deleted!"
