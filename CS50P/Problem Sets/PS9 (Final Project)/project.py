import requests
import json
from datetime import datetime

def main():
    # Gets valid player and information
    while True:
        info = get_playerinfo()
        print(get_bio(info))
        print(get_injury(info))
        print(get_stats(info))
        try_again = input("Would you like to look at another player? Yes|No: ").strip().casefold()
        if try_again in ["yes", "y", "ok", "okay", "sure"]:
            pass
        else:
            print("\nI hope you enjoyed. Try again soon!\n")
            break
    
    ##print(json.dumps(info, indent = 5))

def get_playerinfo():
    url = "https://tank01-nfl-live-in-game-real-time-statistics-nfl.p.rapidapi.com/getNFLPlayerInfo"
    headers = {
	    "X-RapidAPI-Key": "6e224148afmsh23d0a3ea823b941p1c6c9djsn3f98c988f6cc",
	    "X-RapidAPI-Host": "tank01-nfl-live-in-game-real-time-statistics-nfl.p.rapidapi.com"}
    
    path = 1
    while True:
        if path == 1: #skips asking for player again if given list of multiple players (pathway 2)
            player = input("\nPlayer: ").strip().casefold().replace(" ", "_")
        # Sets inputted player for search
        querystring = {"playerName":player,"getStats":"true"}
        # Gets stats from API
        response = requests.get(url, headers=headers, params=querystring).json()["body"]
        # Checks if no players found (pathway 1)
        if len(response) == 0:
            print(f"\n{player.title().replace('_',' ')} not found, please try again.\n")
            path = 1
            pass
        # Checks if multiple players found (pathway 2)
        elif len(response) > 1:
            players = []
            teams = []
            for _ in range(len(response)):
                players.append(response[_]['espnName'])
                teams.append(response[_]['team'])
                print(f"    {response[_]['espnName']} ({response[_]['team']})")

            #acccounts for if all search results have the same or similar names
            if len(set(players)) == 1 or similar_names(players):
                while True:
                    if len(set(teams)) < len(teams):
                        team = teams[0]
                    else:
                        team = input("\nWhich team? (use abbreviation) ").replace("(","").replace(")","").strip().upper()
                    if team not in teams:
                        print("\nPlease choose a valid team among the player's teams listed.")
                        pass
                    else:
                        on_team = []
                        for _ in range(len(response)):
                            if response[_]['team'] == team:
                                on_team.append(_)
                            else:
                                pass
                        if len(on_team) == 1:
                                return response[on_team[0]] # Outputs player info
                        else:
                            print()
                            for _ in on_team:
                                print(f"    {response[_]['pos']} from {response[_]['school']}")
                            while True:
                                position_school = input("Which position (abbreviation) or school? ").strip().casefold()
                                for _ in on_team:
                                    if response[_]['pos'].casefold() == position_school or response[_]['school'].casefold() == position_school:
                                        return response[_] # Outputs player info
                                # If neither valid position or school inputted
                                print("Try again! Input only (1) position or school and ensure spelling is correct.\nPosition input should be an abbreviation. Input the school if the same position.\n")
                                pass

            else:
                player = input("\nWhich one? ")
                path = 2
                pass
        # Outputs player info
        else:
            return response[0]

def get_stats(info):
    while True:
        if len(info["stats"]) == 0:
            return "No stats exist for this player this season.\n"
        # Requests stat of interest
        stat = input("Rushing|Passing|Receiving|Defense|EXIT: ").strip().title()
        # Exits if requested
        if stat in ["Exit", "Quit", "End", "No", "Done"]:
            break
        # Checks if invalid input
        elif stat not in ["Rushing", "Passing", "Receiving", "Defense"]:
            print("\nInvalid input.\n")
            pass
        else:
            stats = info["stats"][stat]
            # Stat output
            match stat:
                case "Rushing":
                    print(f"\nRushing yards: {stats['rushYds']}\nCarries: {stats['carries']}\nRushing TDs: {stats['rushTD']}\n")
                    pass
                case "Passing":
                    print(f"\nPass Attempts: {stats['passAttempts']}\nPass Completions: {stats['passCompletions']}\nPassing Yards: {stats['passYds']}\nPassing TDs: {stats['passTD']}\nInterceptions: {stats['int']}\n")
                    pass
                case "Receiving":
                    print(f"\nTargets: {stats['targets']}\nReceptions: {stats['receptions']}\nReceiving Yards: {stats['recYds']}\nReceiving TDs: {stats['recTD']}\n")
                    pass
                case "Defense":
                    print(f"\nTotal Tackles: {stats['totalTackles']}\nSolo Tackles: {stats['soloTackles']}\nTackles for Loss (TFL): {stats['tfl']}\nSacks: {stats['sacks']}\nQB Hits: {stats['qbHits']}\nPass Deflections: {stats['passDeflections']}\nDefensive Interceptions: {stats['defensiveInterceptions']}\nDefensive TDs: {stats['defTD']}\n")
    return f"\n{info['espnName'].title()} Stats.\n" 

def get_bio(info):
    return f"\n{info['espnName']} ({info['team'] if info['isFreeAgent'] == 'False' else 'FA'}) #{info['jerseyNum']}\nAge: {info['age']} ({info['bDay']})\nHt/Wt: {info['height']}/{info['weight']}\nPosition: {info['pos']}, {info['exp']}th season\nSchool: {info['school']}\n"

def get_injury(info):
    injury = info["injury"]
    if injury["designation"] == "":
        return f"No injury designation\n"
    else:
        return f"Designation: {injury['designation']}\nInjury Date: {datetime.strptime(injury['injDate'], '%Y%m%d').date()}\nDescription: {injury['description']}\n"

#Helper Function
def similar_names(names):
    """
    Check if all but one name is a substring of another in the list.
    """
    not_substring_count = 0
    
    for i in range(len(names)):
        if not any(names[i] in names[j] for j in range(len(names)) if i != j):
            not_substring_count += 1
    
    return not_substring_count <= 1


if __name__ == "__main__":
    main()