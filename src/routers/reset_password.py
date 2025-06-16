# from fastapi import APIRouter, Depends, HTTPException
# from sqlalchemy.orm import Session

# from src.dao.users import create_user, delete_user, update_user
# from src.dependencies import get_db
# from src.models import Users
# from src.schemas import PasswordResetRequest, PasswordReset
# from src.utils import generate_salt, generate_hash_password


# router = APIRouter()


# @router.post("/reset-password")
# def request_password_reset(
#     request: PasswordResetRequest, db: Session = Depends(get_db)
# ):
#     user = db.query(Users).filter(Users.email == request.email).first()
#     if user:
#         # Generate and store a reset token in the database
#         reset_token = generate_reset_token()
#         user.reset_token = reset_token
#         db.commit()

#         # Send the reset token to the user's email
#         send_password_reset_email(user.email, reset_token)

#     # Always return a success message to avoid leaking information about existing accounts
#     return {"message": "Password reset email sent if the email exists"}


# @router.post("/reset-password/{token}")
# def reset_password(token: str, request: PasswordReset, db: Session = Depends(get_db)):
#     user = db.query(Users).filter(Users.reset_token == token).first()
#     if not user:
#         raise HTTPException(status_code=400, detail="Invalid token")

#     # Verify the token and update the password
#     new_salt = generate_salt()
#     new_password_hash = generate_hash_password(
#         password=request.new_password, salt=new_salt
#     )

#     user.password = new_password_hash
#     user.salt = new_salt
#     user.reset_token = None  # Clear the reset token after successful reset

#     db.commit()

#     return {"message": "Password reset successful"}
