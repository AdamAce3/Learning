class Jar:
    def __init__(self, capacity=12):
        self.capacity = capacity
        self.size = 0
    
    def __str__(self):
        return "🍪"*self.size

    def deposit(self, n):
        if not str(n).isdigit():
            raise ValueError("Deposit amount must be a non-negative integer")
        n = int(n)
        if self.size + n > self.capacity:
            raise ValueError("Deposit cannot exceed capacity")
        self.size = self.size + n

    def withdraw(self, n):
        if not str(n).isdigit():
            raise ValueError("Withdrawal amount must be a non-negative integer")
        n = int(n)
        if self.size - n < 0:
            raise ValueError("Withdrawal too large")
        self.size = self.size - n

    @property
    def capacity(self):
        return self._capacity
    
    @capacity.setter
    def capacity(self, capacity):
        if not str(capacity).isdigit() or not int(capacity) >= 0:
            raise ValueError("Capacity must be a non-negative integer")
        self._capacity = int(capacity)

    @property
    def size(self):
        return self._size
    
    @size.setter
    def size(self, size):
        self._size = int(size)
    
def main():
    while True:
        jar = set_capacity()
        print(f"Jar capacity is {jar.capacity}.")
        print(operation(jar))
        while True:
            again = input("Would you like to try again? (yes | no): ").strip().casefold()
            if again == "yes":
                break
            elif again == "no":
                print("Sounds good! See you again soon :)") 
                return 
            else:
                print("Invalid input. Please answer with 'yes' or 'no'!")          

def set_capacity():
    while True:
        try:
            capacity = input("Do you want to set a capacity? (yes | no): ").strip().casefold()
            if capacity == "no":
                return Jar()
            elif capacity == "yes":
                return Jar(input("Capacity: ").strip()) # type: ignore
            else:
                print("Invalid input. Please answer with 'yes' or 'no'!")
        except ValueError as e:
            print(e)
            print("Please try again!")

def operation(jar):
    while True:
        try:
            task = input("Deposit | Withdraw | Balance | EXIT : ").strip().casefold()
            if task == "balance":
                print(f"There are {jar.size} cookies in the jar.")
            elif task == "deposit":
                jar.deposit(input("Deposit Amount: ").strip())
                print(f"There are now {jar.size} cookies in the jar.")
            elif task == "withdraw":
                jar.withdraw(input("Withdrawal Amount: ").strip())
                print(f"There are now {jar.size} cookies in the jar.")
            elif task in ("exit", "quit"):
                return f"The final balance of the jar was {jar.size} out of a capacity of {jar.capacity}!\n {jar}" 
            else:
                print("Invalid input")
        except ValueError as e:
            print(e)
            print("Please try again!")

if __name__ == "__main__":
    main()