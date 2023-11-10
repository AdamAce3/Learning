import sys
from PIL import (Image, ImageOps)

if len(sys.argv) < 3:
    sys.exit("Too few command-line arguments")
elif len(sys.argv) > 3:
    sys.exit("Too many command-line arguments")
elif not sys.argv[1].endswith((".jpg",".jpeg",".png")):
    sys.exit("Invalid Input")
elif not sys.argv[2].endswith((".jpg",".jpeg",".png")):
    sys.exit("Invalid Output")
elif sys.argv[1].split(".")[1] != sys.argv[2].split(".")[1]:
    sys.exit("Input and output have different extensions")
try:
    shirt = Image.open("shirt.png")
    photo = ImageOps.fit(Image.open(sys.argv[1]), shirt.size)
    photo.paste(shirt, shirt) # type: ignore
    photo.save(sys.argv[2])
except FileNotFoundError:
    sys.exit("Input does not exist")