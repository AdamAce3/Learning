def main():
    print_column(3)

def print_column(height):
    for _ in range(height):
        print("#")
    #could also do print("\n" * height, end = "")

main()