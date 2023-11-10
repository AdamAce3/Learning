import csv
import sys

if len(sys.argv) < 3:
    sys.exit("Too few command-line arguments")
elif len(sys.argv) > 3:
    sys.exit("Too many command-line arguments")
try:
    with open(sys.argv[1]) as file1:
        reader = csv.DictReader(file1)
        first = []
        last = []
        house = []
        for row in reader:
            first.append(row["name"].split()[1])
            last.append(row["name"].split()[0].removesuffix(","))
            house.append(row["house"])
    with open(sys.argv[2], "w") as file2:
        writer = csv.DictWriter(file2, fieldnames = ["first", "last", "house"])
        writer.writeheader()
        for _ in range(len(first)):
            writer.writerow({"first": first[_], "last": last[_], "house": house[_]})
except FileNotFoundError:
    sys.exit(f"Could not read {sys.argv[1]}")