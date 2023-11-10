months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
    ]

while True:
    date_input = input("Date: ").strip()
    try:
        month, day, year = date_input.split(" ")
        if day.endswith(","):
            day = int(day.removesuffix(","))
        else:
            pass
        month = int(months.index(month)) + 1
    except ValueError:
        try:
            month, day, year = date_input.split("/")
            day = int(day)
            month = int(month)
        except ValueError:
            pass
    if len(year) == 4 and month in range(12) and day in range(31): # type: ignore
        break
    else:
        pass

print(f"{year}-{month:02}-{day:02}") # type: ignore
