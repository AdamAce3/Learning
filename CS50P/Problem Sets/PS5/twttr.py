def main():
    word = input("Input: ").strip()
    shorten(word)

def shorten(word):
    wrd = ""
    for letter in word:
        if letter.casefold() in ["a", "e", "i", "o", "u"]:
            wrd = wrd
        else:
            wrd = wrd + letter
    return f"{wrd}"

if __name__ == "__main__":
    main()