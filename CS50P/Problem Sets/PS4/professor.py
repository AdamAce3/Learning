import random

def main():
    level = get_level()
    problem = 1
    correct = 0
    while problem <= 10:
        x = generate_integer(level)
        y = generate_integer(level)
        answer = x + y # type: ignore
        attempt = 0
        while attempt < 3:
            try:
                guess = int(input(f"{x} + {y} = "))
                if answer == guess:
                    correct += 1
                    break
                else:
                    raise ValueError
            except ValueError:
                attempt += 1
                print("EEE")
            if attempt == 3:
                print(f"{x} + {y} = {answer}")
        problem += 1
    print(f"Score: {correct}")

def get_level():
    while True:
        try:
            level = int(input("Level: ").strip())
            if level not in [1, 2, 3]:
                raise ValueError
            else:
                return level
        except ValueError:
            pass

def generate_integer(level):
    try:
        level = int(level)
        if level not in [1, 2, 3]:
            raise ValueError
        else:
            if level == 1:
                return int(random.randint(0, 9))
            else:
                return int(random.randint(int("1"+"0"*(level-1)), int("9"*level)))
    except ValueError:
        print("level must be 1, 2, or 3")


if __name__ == "__main__":
    main()