while True:
    try:
        x,y = input("Fraction: ").split("/")
        x = int(x)
        y = int(y)
        perc = round(x/y*100)
    except (ValueError, ZeroDivisionError):
        pass
    else:
        if x > y:
            pass
        else:
            break

if perc <= 1:
    print("E")
elif perc >= 99:
    print("F")
else:
    print(f"{perc}%")
