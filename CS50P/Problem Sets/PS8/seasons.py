from datetime import date
import sys
import re
import inflect

p = inflect.engine()

def main():
    dob = get_date(input("Date of Birth: "))
    diff = get_diffTOtoday_minutes(dob)
    print(p.number_to_words(diff, andword="").capitalize(), "minutes")

def get_diffTOtoday_minutes(d):
    today = date.today()
    difference = today - d
    return difference.days*24*60

def get_date(d):
    if not re.fullmatch(r"\d{4}-\d{2}-\d{2}", d):
        sys.exit("Invalid date")
    else:
        year, month, day = d.split("-")
        return date(int(year), int(month), int(day))


if __name__ == "__main__":
    main()