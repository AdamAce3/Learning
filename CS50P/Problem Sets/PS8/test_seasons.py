import pytest
from datetime import date
from seasons import (get_diffTOtoday_minutes, get_date)

def test_get_date():
    assert get_date("2023-08-21") == date(2023, 8, 21)
    assert get_date("1999-12-12") == date(1999, 12, 12)
    with pytest.raises(SystemExit):
        get_date("cat")
        get_date("08-21-2023")
        get_date("July 12th, 2003")
