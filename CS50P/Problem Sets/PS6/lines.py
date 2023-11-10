import sys

if len(sys.argv) < 2:
    sys.exit("Too few command-line arguments")
elif len(sys.argv) > 2:
    sys.exit("Too many command-line arguments")
elif not sys.argv[1].endswith(".py"):
    sys.exit("Not a python file")
else:
    try:
        with open(sys.argv[1]) as file:
            counter = 0
            for line in file:
                if line.lstrip().startswith("#") or line.strip() == "":
                    pass
                else:
                    counter += 1
            print(counter)
    except FileNotFoundError:
        sys.exit("File does not exist")