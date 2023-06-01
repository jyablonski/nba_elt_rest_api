from src.utils import generate_salt


def test_generate_salt():
    salt = generate_salt()
    salt2 = generate_salt(32)

    assert len(salt) == 32
    assert len(salt2) == 32
