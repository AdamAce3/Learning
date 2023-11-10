from plates import is_valid

def test_startswith2L():
    assert is_valid("xyabcd") == True
    assert is_valid("XYabcd") == True
    assert is_valid("1xabcd") == False
    assert is_valid("x1abcd") == False
    assert is_valid("12abcd") == False

def test_minmaxchrs():
    assert is_valid("xyz123") == True
    assert is_valid("abc") == True
    assert is_valid("w") == False
    assert is_valid("abcdefg") == False

def test_endnumb():
    assert is_valid("xyzab1") == True
    assert is_valid("xyza12") == True
    assert is_valid("xy12bc") == False
    assert is_valid("xyz12a") == False

def test_firstnumNOT0():
    assert is_valid("xyza10") == True
    assert is_valid("xyza01") == False

def test_noPeriodsSpacesPunct():
    assert is_valid("xyz.12") == False
    assert is_valid("xyz12 ") == False
    assert is_valid("xyz12!") == False
    assert is_valid("xyz!12") == False