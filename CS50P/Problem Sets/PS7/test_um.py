from um import count

def test_valid():
    assert count("") == 0
    assert count("hello") == 0
    assert count("um") == 1
    assert count("um um") == 2
    assert count("um test um") == 2
    assert count("hello um test um mu um") == 3

def test_case():
    assert count("Um?") == 1
    assert count("UM") == 1
    assert count("uM") == 1

def test_umINwords():
    assert count("mum") == 0
    assert count("yummy") == 0
    assert count("umani") == 0
    assert count("umum") == 0

def test_punct():
    assert count("um.") == 1
    assert count("um,") == 1
    assert count("um?") == 1
    assert count("(um)") == 1
    assert count("um;") == 1