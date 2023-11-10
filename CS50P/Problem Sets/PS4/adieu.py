import inflect


names = []
while True:
    try:
        names.append(input("Name: ").strip().title())
    except EOFError:
        print()
        break

print("Adieu, adieu, to", inflect.engine().join(names))