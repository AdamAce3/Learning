def main():
    user_input = str(input("What would you like to convert? "))
    convert(user_input)


def convert(string):
    if ":)" or ":(" in string:
        return print(string.replace(":)", "🙂").replace(":(", "🙁"))
    else:
        return print(string)

main()