import re
import sys


def main():
    print(parse(input("HTML: ").strip()))


def parse(s):
    if link := re.search(r'src="(?:https?://)?(?:www\.)?youtube\.com/embed/([a-zA-Z0-9]+)"', s):
        return f"https://youtu.be/{link.group(1)}"
    else:
        return None


if __name__ == "__main__":
    main()