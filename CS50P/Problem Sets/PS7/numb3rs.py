import re
import sys

def main():
    print(validate(input("IPv4 Address: ").strip()))


def validate(ip):
    if ip := re.fullmatch(r"([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})", ip):
        for group in ip.groups():
            if int(group) > 255 or int(group) > 0 and group.startswith("0"):
                return False
            else:
                pass
        return True
    else:
        return False


if __name__ == "__main__":
    main()