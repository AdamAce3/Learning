import sys

try:
    print("hello, my name is", sys.argv[1])
except IndexError:
    print("Two few arguments")

#python3 name.py <Argument> 
## in terminal