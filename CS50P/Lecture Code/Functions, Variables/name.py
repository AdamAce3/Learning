#reformat text to remove unnessary spaces and capitilize first letters
name = input("What is your name? ").strip().title() 
#splits first and last name in two variables
first, last = name.split()

#prints response formatted
print(f"hello, {first}")
