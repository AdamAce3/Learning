import csv

students = []

with open("students.csv") as file:
    reader = csv.DictReader(file)
    for row in reader:
        students.append({"name": row["name"], "home": row["home"]})

def get_name(student):
    return student["name"]

for student in sorted(students, key = lambda student: student["home"]):
    print(f"{student['name']} is in {student['home']}")