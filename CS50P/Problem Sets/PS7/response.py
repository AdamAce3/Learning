from validators import email

if email(input("What's your email address? ").strip()):
    print("Valid")
else:
    print("Invalid")