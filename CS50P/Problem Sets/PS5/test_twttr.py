from twttr import shorten

def test_lowercase():
    assert shorten("sequoia") == "sq"
    assert shorten("eutopia") == "tp"

def test_uppercase():
    assert shorten("SEQUOIA") == "SQ"
    assert shorten("EUTOPIA") == "TP"

def test_noVowels():
    assert shorten("xyz") == "xyz"
    assert shorten("BCD") == "BCD"

def test_onlyVowels():
    assert shorten("aei") == ""
    assert shorten("OU") == ""

def test_numb():
    assert shorten("123") == "123"
    assert shorten("1a2b3c") == "12b3c"

def test_punct():
    assert shorten("abc.xyz") == "bc.xyz"
