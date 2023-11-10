from bank import value

def test_hello():
    assert value("hello") == 0
    assert value("HELLO") == 0
    assert value("Hello") == 0

def test_starth():
    assert value("h") == 20
    assert value("harry") == 20
    assert value("HARRY") == 20

def test_noh():
    assert value("a") == 100
    assert value("B") == 100
    assert value("john") == 100
    assert value("JOHN") == 100
    assert value("!harry") == 100