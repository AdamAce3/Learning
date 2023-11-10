from working import convert
import pytest

def test_morning():
    assert convert("9:00 AM to 5:00 PM") == "09:00 to 17:00"
    assert convert("9 AM to 5 PM") == "09:00 to 17:00"
    assert convert("10:00 AM to 11:00 PM") == "10:00 to 23:00"
    assert convert("10 AM to 11 PM") == "10:00 to 23:00"

def test_night():
    assert convert("5:00 PM to 9:00 AM") == "17:00 to 09:00"
    assert convert("5 PM to 9 AM") == "17:00 to 09:00"
    assert convert("11:00 PM to 10:00 AM") == "23:00 to 10:00"
    assert convert("11 PM to 10 AM") == "23:00 to 10:00"

def test_12():
    assert convert("12:00 AM to 12:00 PM") == "00:00 to 12:00"
    assert convert("12 AM to 12 PM") == "00:00 to 12:00"
    assert convert("12:00 PM to 12:00 AM") == "12:00 to 00:00"
    assert convert("12 PM to 12 AM") == "12:00 to 00:00"

def test_range():
    with pytest.raises(ValueError):
        convert("9:60 AM to 5:60 PM")
        convert("13 AM to 20 AM")
        convert("13:00 AM to 20:00 AM")

def test_format():
    with pytest.raises(ValueError):
        convert("9 AM 5 AM")
        convert("9 to 5")
        convert("9:00 AM - 5:00 AM")
        convert("cat")
        convert("nine to five")
        convert("9:00 am to 5:00 pm")
        convert("9 a.m. to 5 p.m.")