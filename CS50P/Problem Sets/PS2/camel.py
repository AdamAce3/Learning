camelCase = input("camelCase: ").strip()
snake_case = ""

for letter in camelCase:
    if letter.islower():
        snake_case = snake_case + letter
    elif letter.isupper():
        snake_case = snake_case + "_" + letter.casefold()

print(snake_case)