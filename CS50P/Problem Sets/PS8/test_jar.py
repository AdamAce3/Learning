from jar import Jar
import pytest

def test_init():
    jar = Jar()
    assert jar.capacity == 12
    jar = Jar(100)
    assert jar.capacity == 100
    with pytest.raises(ValueError):
        Jar(-1)
        jar.capacity = -1
        jar.capacity = .5
        jar.capacity = "cat"


def test_str():
    jar = Jar()
    assert str(jar) == ""
    jar.deposit(1)
    assert str(jar) == "🍪"
    jar.deposit(11)
    assert str(jar) == "🍪🍪🍪🍪🍪🍪🍪🍪🍪🍪🍪🍪"


def test_deposit():
    jar = Jar()
    jar.deposit(0)
    assert jar.size == 0
    jar.deposit(1)
    assert jar.size == 1
    jar.deposit(10)
    assert jar.size == 11
    with pytest.raises(ValueError):
        jar.deposit(2)
        jar.deposit(-1)
        jar.deposit(.5)
        jar.deposit("cat")


def test_withdraw():
    jar = Jar()
    jar.deposit(12)
    jar.withdraw(0)
    assert jar.size == 12
    jar.withdraw(1)
    assert jar.size == 11
    jar.withdraw(10)
    assert jar.size == 1
    with pytest.raises(ValueError):
        jar.withdraw(2)
        jar.withdraw(-1)
        jar.withdraw(.5)
        jar.withdraw("cat")