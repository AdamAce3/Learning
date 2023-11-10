import random

#Choosing level and generating answer
while True:
    try:
        level = int(input("Level: "))
        if level <= 0:
            pass
        else:
            answer = random.randint(1, level)
            break
    except ValueError:
        pass

#Guessing game
while True:
    try:
        guess = int(input("Guess: "))
        if guess <= 0:
            pass
        else:
            if guess < answer:
                print("Too small!")
                pass
            elif guess > answer:
                print("Too large!")
                pass
            else:
                print("Just right!")
                break
    except ValueError:
        pass