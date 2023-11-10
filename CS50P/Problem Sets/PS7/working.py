import re
import sys


def main():
    print(convert(input("Hours: ").strip()))


def convert(s):
    if time := re.fullmatch(r"(1[0-2]|[0-9])(?:\:?([0-5][0-9]))?\s(AM|PM)\sto\s(1[0-2]|[0-9])(?:\:([0-5][0-9]))?\s(AM|PM)", s):
        #defining the minutes
        if time.group(2) and time.group(5):
            start_m = int(time.group(2))
            finish_m = int(time.group(5))
        else:
            start_m = 0
            finish_m = 0
        #defining the hours
        if int(time.group(1)) == 12: #fixing 12 corner case for start time
            if time.group(3) == "AM":
                start_h = 0
            elif time.group(3) == "PM":
                start_h = 12
        elif time.group(3) == "PM":
            start_h = int(time.group(1)) + 12
        else:
            start_h = int(time.group(1))
        if int(time.group(4)) == 12: #fixing 12 corner case for finish time
            if time.group(6) == "AM":
                finish_h = 0
            elif time.group(6) == "PM":
                finish_h = 12
        elif time.group(6) == "PM":
            finish_h = int(time.group(4)) + 12
        else:
            finish_h = int(time.group(4))
        return f"{start_h:02}:{start_m:02} to {finish_h:02}:{finish_m:02}"
    else:
        raise ValueError



if __name__ == "__main__":
    main()