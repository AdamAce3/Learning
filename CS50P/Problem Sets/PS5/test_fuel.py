from fuel import convert, gauge
import pytest

def test_convert_valid():
    assert convert("3/4") == 75
    assert convert("1/2") == 50
    assert convert("5/5") == 100

def test_convert_xgreater():
    with pytest.raises(ValueError):
        assert convert("4/3")
        assert convert("2/1")

def test_convert_yzero():
    with pytest.raises(ZeroDivisionError):
        assert convert("4/0")
        assert convert("2/0")
        assert convert("0/0")

def test_guage_E():
    assert gauge(1) == "E"
    assert gauge(0) == "E"

def test_guage_F():
    assert gauge(99) == "F"
    assert gauge(100) == "F"

def test_guage_other():
    assert gauge(75) == "75%"
    assert gauge(50) == "50%"
    assert gauge(2) == "2%"
    assert gauge(98) == "98%"