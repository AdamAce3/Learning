from pyfiglet import Figlet
figlet = Figlet()
import random
import sys

fonts = figlet.getFonts()

if len(sys.argv) == 1:
    word = input("Input: ")
    figlet.setFont(font = random.choice(fonts))
    print(figlet.renderText(word))
elif len(sys.argv) == 3 and sys.argv[1] in ["-f", "--font"] and sys.argv[2] in fonts:
        word = input("Input: ")
        figlet.setFont(font = sys.argv[2])
        print(figlet.renderText(word))
else:
    sys.exit("Invalid usage")

