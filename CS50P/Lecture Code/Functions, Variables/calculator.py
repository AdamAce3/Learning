#asks for variables and converts to float
x = float(input("What is x? "))
y = float(input("What is y? "))

#rounds the sum of x and y to 2 decimal places
z=round(x+y, 2)

#prints a formatted string using commas as place seperators
print(f"{z:,}")