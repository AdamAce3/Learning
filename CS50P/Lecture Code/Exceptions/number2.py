def main():
    x = get_int("What's x? ")
    print(f"x is {x}")

#more reusable fn bc can ask for any prompt and check if int
def get_int(prompt):
    while True:
        try:
            return int(input(prompt)) 
        except ValueError:
            pass
            

main()