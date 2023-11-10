import random

class Hat:
    houses = ["Gryffindor", "Hufflepuff", "Ravenclaw", "Slytherin"]
    #class variable

    @classmethod
    def sort(cls, name): #class method
        print(name, "is in", random.choice(cls.houses))

Hat.sort("Harry")