import csv
import sys
from tabulate import tabulate

rows = []

if len(sys.argv) < 2:
    sys.exit("Too few command-line arguments")
elif len(sys.argv) > 2:
    sys.exit("Too many command-line arguments")
elif not sys.argv[1].endswith(".csv"):
    sys.exit("Not a CSV file")
else:
    with open(sys.argv[1]) as file:
        reader = csv.reader(file)
        for row in reader:
            rows.append(row)
        print(tabulate(rows, headers = "firstrow", tablefmt="grid"))