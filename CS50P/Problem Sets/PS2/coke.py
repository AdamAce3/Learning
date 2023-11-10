amount_due = 50

while amount_due > 0:
    print(f"Amount Due: {amount_due}")
    insert = int(input("Insert Coin: "))
    if insert in [25, 10, 5]:
        amount_due = amount_due - insert
    else:
        amount_due = amount_due

change = abs(amount_due)
print(f"Change Owed: {change}")