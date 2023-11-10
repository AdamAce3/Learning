def main():
    plate = input("Plate: ")
    if is_valid(plate):
        print("Valid")
    else:
        print("Invalid")

def is_valid(s):
    if s[0:2].isalpha():
        if 2 <= len(s) <= 6:
            any_numbers = False
            for i in s:
                if i.isdigit():
                    if int(i) == 0 and not any_numbers:
                        return False
                    any_numbers = True
                elif i.isalpha():
                   if any_numbers:
                       return False
                else:
                    return False
            return True
    else:
        return False


main()