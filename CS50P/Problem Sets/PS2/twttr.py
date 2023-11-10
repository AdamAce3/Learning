word = input("Input: ").strip()
wrd = ""

for letter in word:
    if letter.casefold() in ["a", "e", "i", "o", "u"]:
        wrd = wrd
    else:
        wrd = wrd + letter

print(f"Output: {wrd}")