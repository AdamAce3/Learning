from numb3rs import validate

def test_range():
    assert validate("0.0.0.0") == True
    assert validate("1.1.1.1") == True
    assert validate("11.11.11.11") == True
    assert validate("111.111.111.111") == True
    assert validate("255.255.255.255") == True
    assert validate("256.256.256.256") == False
    assert validate("256.255.255.255") == False
    assert validate("255.256.255.255") == False
    assert validate("255.255.256.255") == False
    assert validate("255.255.255.256") == False
    #assert validate("01.01.01.01") == False

def test_format():
    assert validate("....") == False
    assert validate("1.1.1.1.1") == False
    assert validate("1.1.1") == False
    assert validate("a.b.c.d") == False
    assert validate("cat") == False