import requests
import sys
import json

if len(sys.argv) < 2:
    sys.exit("Missing command-line argument")
else:
    try:
        n = float(sys.argv[1])
    except ValueError:
        sys.exit("Command-line argument is not a number")
    try:
        api = requests.get("https://api.coindesk.com/v1/bpi/currentprice.json").json()
        rate = float(api["bpi"]["USD"]["rate"].replace(",", ""))
        amount = rate*n
        print(f"${amount:,.4f}")
    except requests.RequestException:
        sys.exit("Could not get current price from CoinDesk's API")