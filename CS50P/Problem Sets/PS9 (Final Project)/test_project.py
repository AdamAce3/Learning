import pytest
from project import get_playerinfo, get_stats, get_bio, get_injury
import requests
from datetime import datetime

# **FILL TO TEST**
# Ensure correct spelling with space between firstName and lastName!
# If none, input None for player name (except for player_withstats)
##For usefulness, please at least fill out player_withstats or player_nostats
##UNIQUE as in only one exists within its context (eg. only 1 "John Doe" in league, only 1 "SEA" player among search, or only 1 "RB" among search)
##SAME as in exactly the equal, albeit non-case-sentatively (eg. "John Doe" and "John Doe")
##SIMILAR as in one name is contained within another (eg. "John Doe" & "John Doe II")
## UPDATED: OCT 21, 2023 06:30 PM

##UNIQUE Player WITH current season stats 
player_withstats = "Travis Kelce"
##UNIQUE Player WITHOUT current season stats
player_nostats = "Tom Brady"
##Player with COMMON first or last name (so multiple results appear when inputted)
###Ensure player full name is UNIQUE
player_mult = "Tom Brady" 
player_mult_common = "Brady" #what's in common
##Player WITH injury
player_withinjury = "Anthony Richardson"
##Player WITHOUT injury
player_withoutinjury = "Raheem Mostert"
##Name of players with the SAME name and team of one of them (ensure player name on team UNIQUE)
player_sameName = "Josh Allen" 
player_sameName_team = "BUF" #one player' team (abbreviation eg. SEA)
##Name of player with a SIMILAR name with another player 
###(if position or school not UNIQUE, input None)
player_similarName = "Michael Carter"
player_similarName_pos = "RB"
player_similarName_school = "North Carolina"
##Name of players with the SAME name on the SAME team and UNIQUE school or position of one of them
###(if position or school not UNIQUE, input None)
player_sameNamePos = None 
player_sameNamePos_pos = None
player_sameNamePos_school = None





# API info
url = "https://tank01-nfl-live-in-game-real-time-statistics-nfl.p.rapidapi.com/getNFLPlayerInfo"
headers = {
	    "X-RapidAPI-Key": "6e224148afmsh23d0a3ea823b941p1c6c9djsn3f98c988f6cc",
	    "X-RapidAPI-Host": "tank01-nfl-live-in-game-real-time-statistics-nfl.p.rapidapi.com"}

# Getting players Info from API for Tests  **DO NOT TOUCH**
##Player WITH current season stats
querystring = {"playerName":player_withstats,"getStats":"true"}
player_withstats_info = requests.get(url, headers=headers, params=querystring).json()["body"][0]
##Player WITHOUT current season stats
querystring = {"playerName":player_nostats,"getStats":"true"}
player_nostats_info = requests.get(url, headers=headers, params=querystring).json()["body"][0]
##Player with COMMON first or last name (so multiple results appear when inputted)
querystring = {"playerName":player_mult,"getStats":"true"}
player_mult_info = requests.get(url, headers=headers, params=querystring).json()["body"]
for _ in range(len(player_mult_info)):
    if player_mult_info[_]['espnName'] == player_mult:
        player_mult_info1 = player_mult_info[_]
    else:
        pass
##Player WITH injury
querystring = {"playerName":player_withinjury,"getStats":"true"}
injured_player_info = requests.get(url, headers=headers, params=querystring).json()["body"][0] #complete info
injured_player_injury = injured_player_info["injury"] #injury info
##Player WITHOUT injury
querystring = {"playerName":player_withoutinjury,"getStats":"true"}
uninjured_player_info = requests.get(url, headers=headers, params=querystring).json()["body"][0] #complete info
##Name of players with the SAME name and team (abbreviation eg. BUF) of desired player
querystring = {"playerName":player_sameName,"getStats":"true"}
player_sameName_info = requests.get(url, headers=headers, params=querystring).json()["body"]
for _ in range(len(player_sameName_info)):
    if player_sameName_info[_]['team'] == player_sameName_team:
        player_sameName_info1 = player_sameName_info[_]
##Name of player with a SIMILAR name with another player
querystring = {"playerName":player_similarName,"getStats":"true"}
player_similarName_info = requests.get(url, headers=headers, params=querystring).json()["body"]
for _ in range(len(player_similarName_info)):
    if player_similarName_info[_]['pos'] == player_similarName_pos or player_similarName_info[_]['school'] == player_similarName_school:
        player_similarName_info1 = player_similarName_info[_]        
##Name of players with the SAME name on the SAME team and UNIQUE school or position of one of them
querystring = {"playerName":player_sameNamePos,"getStats":"true"}
player_sameNamePos_info = requests.get(url, headers=headers, params=querystring).json()["body"]
for _ in range(len(player_sameNamePos_info)):
    if player_sameNamePos_info[_]['pos'] == player_sameNamePos_info or player_sameNamePos_info[_]['school'] == player_sameNamePos_info:
        player_sameNamePos_info1 = player_sameNamePos_info[_] 





## TESTS BELOW

#The following are variations of getplayerinfo() inputs
def test_getplayerinfo_one(monkeypatch):
    # Input associated to only 1 player
    if player_withstats != None:
        monkeypatch.setattr("builtins.input", lambda _: player_withstats)
        assert get_playerinfo() == player_withstats_info
        # Checking for case sensativity
        monkeypatch.setattr("builtins.input", lambda _: player_withstats.lower())
        assert get_playerinfo() == player_withstats_info
        monkeypatch.setattr("builtins.input", lambda _: player_withstats.upper())
        assert get_playerinfo() == player_withstats_info
    elif player_nostats != None:
        monkeypatch.setattr("builtins.input", lambda _: player_nostats)
        assert get_playerinfo() == player_nostats_info
        # Checking for case sensativity
        monkeypatch.setattr("builtins.input", lambda _: player_nostats.lower())
        assert get_playerinfo() == player_nostats_info
        monkeypatch.setattr("builtins.input", lambda _: player_nostats.upper())
        assert get_playerinfo() == player_nostats_info

def test_getplayerinfo_mult(monkeypatch, capsys):
    # Input associated with multiple players
    if player_mult != None:
        mock_inputs = iter([player_mult_common, player_mult])
        monkeypatch.setattr("builtins.input", lambda _: next(mock_inputs))
        assert get_playerinfo() == player_mult_info1
        captured = capsys.readouterr()
        #Checks options after "Which one? "
        for _ in range(len(player_mult_info)):
            assert f"{player_mult_info[_]['espnName']} ({player_mult_info[_]['team']})\n" in captured.out

def test_getplayerinfo_invalid(monkeypatch, capsys):
    # Invalid Input
    if player_withstats != None:
        mock_inputs = iter(["invalid player", player_withstats])
        monkeypatch.setattr("builtins.input", lambda _: next(mock_inputs))
        assert get_playerinfo() == player_withstats_info
        captured = capsys.readouterr()
        assert "\nInvalid Player not found, please try again.\n" in captured.out
    elif player_nostats != None:
        mock_inputs = iter(["invalid player", player_nostats])
        monkeypatch.setattr("builtins.input", lambda _: next(mock_inputs))
        assert get_playerinfo() == player_nostats_info
        captured = capsys.readouterr()
        assert "\nInvalid Player not found, please try again.\n" in captured.out

def test_getplayerinfo_sameName(monkeypatch, capsys):
    # Testing for players with the same name
    if player_sameName != None:
        mock_inputs = iter([player_sameName, "invalid team", player_sameName_team]) #team as clarification
        # Invalid team also tested for output
        monkeypatch.setattr("builtins.input", lambda _: next(mock_inputs))
        assert get_playerinfo() == player_sameName_info1
        captured = capsys.readouterr()
        assert f"\nPlease choose a valid team among the player's teams listed." in captured.out

def test_getplayerinfo_similarName(monkeypatch, capsys):
    # Testing for players with similar names
    if player_similarName != None:
        if player_similarName_pos != None:
            mock_inputs = iter([player_similarName, player_similarName_pos]) #position as clarification
            monkeypatch.setattr("builtins.input", lambda _: next(mock_inputs))
            assert get_playerinfo() == player_similarName_info1
        if player_similarName_school != None:
            mock_inputs = iter([player_similarName, player_similarName_school]) #school as clarification
            monkeypatch.setattr("builtins.input", lambda _: next(mock_inputs))
            assert get_playerinfo() == player_similarName_info1

def test_getplayerinfo_sameNamePos(monkeypatch): #Untested because currently DNE
    # Testing for players with the same name and team
    if player_sameNamePos != None:
        if player_sameNamePos_pos != None:
            mock_inputs = iter([player_sameNamePos, player_sameNamePos_pos]) #position as clarification
            monkeypatch.setattr("builtins.input", lambda _: next(mock_inputs))
            assert get_playerinfo() == player_sameNamePos_info1
        if player_sameNamePos_school != None:
            mock_inputs = iter([player_sameNamePos, player_sameNamePos_school]) #school as clarification
            monkeypatch.setattr("builtins.input", lambda _: next(mock_inputs))
            assert get_playerinfo() == player_sameNamePos_info1


#The following are tests for the other functions aside from get_playerinputs()
def test_get_stats(monkeypatch, capsys):

    # Player with no stats in current season
    if player_nostats != None:
        assert get_stats(player_nostats_info) == "No stats exist for this player this season.\n"

    # Player with stats in current season
    if player_withstats != None:
        mock_inputs = iter(["Rushing", "Passing", "Receiving", "Defense", "Exit"])
        monkeypatch.setattr("builtins.input", lambda _: next(mock_inputs))
        assert get_stats(player_withstats_info) == f"\n{player_withstats} Stats.\n"
        stats = player_withstats_info["stats"] # Raheem Mostert's stats from api
        captured = capsys.readouterr()
        assert f"\nRushing yards: {stats['Rushing']['rushYds']}\nCarries: {stats['Rushing']['carries']}\nRushing TDs: {stats['Rushing']['rushTD']}\n" in captured.out
        assert f"\nPass Attempts: {stats['Passing']['passAttempts']}\nPass Completions: {stats['Passing']['passCompletions']}\nPassing Yards: {stats['Passing']['passYds']}\nPassing TDs: {stats['Passing']['passTD']}\nInterceptions: {stats['Passing']['int']}\n" in captured.out
        assert f"\nTargets: {stats['Receiving']['targets']}\nReceptions: {stats['Receiving']['receptions']}\nReceiving Yards: {stats['Receiving']['recYds']}\nReceiving TDs: {stats['Receiving']['recTD']}\n" in captured.out
        assert f"\nTotal Tackles: {stats['Defense']['totalTackles']}\nSolo Tackles: {stats['Defense']['soloTackles']}\nTackles for Loss (TFL): {stats['Defense']['tfl']}\nSacks: {stats['Defense']['sacks']}\nQB Hits: {stats['Defense']['qbHits']}\nPass Deflections: {stats['Defense']['passDeflections']}\nDefensive Interceptions: {stats['Defense']['defensiveInterceptions']}\nDefensive TDs: {stats['Defense']['defTD']}\n" in captured.out

def test_get_bio():
    if player_withstats != None:
        assert get_bio(player_withstats_info) == f"\n{player_withstats_info['espnName']} ({player_withstats_info['team'] if player_withstats_info['isFreeAgent'] == 'False' else 'FA'}) #{player_withstats_info['jerseyNum']}\nAge: {player_withstats_info['age']} ({player_withstats_info['bDay']})\nHt/Wt: {player_withstats_info['height']}/{player_withstats_info['weight']}\nPosition: {player_withstats_info['pos']}, {player_withstats_info['exp']}th season\nSchool: {player_withstats_info['school']}\n"
    elif player_nostats != None:
        assert get_bio(player_nostats_info) == f"\n{player_nostats_info['espnName']} ({player_nostats_info['team'] if player_nostats_info['isFreeAgent'] == 'False' else 'FA'}) #{player_nostats_info['jerseyNum']}\nAge: {player_nostats_info['age']} ({player_nostats_info['bDay']})\nHt/Wt: {player_nostats_info['height']}/{player_nostats_info['weight']}\nPosition: {player_nostats_info['pos']}, {player_nostats_info['exp']}th season\nSchool: {player_nostats_info['school']}\n"

def test_get_injury():
    if player_withoutinjury != None:
        assert get_injury(uninjured_player_info) == f"No injury designation\n"
    if player_withinjury != None:
        assert get_injury(injured_player_info) == f"Designation: {injured_player_injury['designation']}\nInjury Date: {datetime.strptime(injured_player_injury['injDate'], '%Y%m%d').date()}\nDescription: {injured_player_injury['description']}\n"