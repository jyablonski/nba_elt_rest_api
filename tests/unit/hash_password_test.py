from src.utils import generate_hash_password, generate_salt


def test_generate_hash_password():
    password = "jacobs_password"

    hash_password = generate_hash_password(password=password, salt="cornbeefhash",)

    assert len(hash_password) == 32
    assert hash_password == "b7376e5ecc3e5207fbc35f5d91a885ab"


def test_hash_salt_password():
    password = "jacobs_password"
    salt = generate_salt()

    hash_password = generate_hash_password(password=password, salt=salt,)

    assert len(hash_password) == 32
    assert hash_password != password
