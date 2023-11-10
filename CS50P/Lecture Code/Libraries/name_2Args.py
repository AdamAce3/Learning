import sys

#Check for errors
if len(sys.argv) < 2:
    sys.exit("Two few arguments")
elif len(sys.argv) > 2:
    sys.exit("Two many arguments")

#Print name tags
print("hello, my name is", sys.argv[1])
