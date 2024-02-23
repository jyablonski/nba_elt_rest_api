import string
import random

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


def check_oauth_user(db: Session, user_email: str) -> bool:
    user = db.query(Users).filter(Users.username == user_email).first()

    if user:
        return True
    else:
        return False


def create_oauth_user(db: Session, user_email: str) -> Users:
    """
    Function to create Users that signed in via Google OAuth.

    2024-02-22 - wasn't sure how to implement this without them
    entering a password.  Ended up creating a Random Password &
    if they log in with Gmail then they will only be able to
    continue logging in with that.

    Args:
        db (Session): Database Session Variable

        user_email (str): User Email from the provided Token from
            Google

    Returns:
        Users Record to display information in the /login Page
    """
    characters = string.ascii_letters + string.digits
    random_password = "".join(random.choice(characters) for _ in range(32))
    salt = generate_salt()

    password_hash = generate_hash_password(password=random_password, salt=salt)

    record = Users(
        username=user_email,
        password=password_hash,
        email=user_email,
        salt=salt,
    )

    db.add(record)
    db.commit()
    db.refresh(record)

    return record
