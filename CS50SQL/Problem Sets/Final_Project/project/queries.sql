-- All players who are currently active in the league
SELECT * 
FROM `active_players`;

-- List all current players from a team based on the team's name
SELECT * 
FROM `current_players_by_team`
WHERE name = 'Seahawks'  -- Replace 'Seahawks' with desired team name
ORDER BY `first_name`, `last_name`;
-- List all current players from a team based on the team's code
SELECT * 
FROM `current_players_by_team `
WHERE name = (SELECT `name` 
                FROM `teams` 
                WHERE `code` = 'SEA')  -- Replace 'SEA' with desired team code
ORDER BY `first_name`, `last_name`;
-- List all current players from a team based on the team's location
SELECT * 
FROM `current_players_by_team`
WHERE name = (SELECT `name` 
                FROM `teams` 
                WHERE `location` = 'Seattle')  -- Replace 'Seattle' with desired team location
ORDER BY `first_name`, `last_name`;

-- Retrieve the seasonal rushing statistics for a player with a given first and last name 
-- (e.g., John Doe)
SELECT * 
FROM `player_season_rushing_stats_view`
WHERE `player_id` = (SELECT `id` 
                        FROM `players` 
                        WHERE `first_name` = 'John' 
                            AND `last_name` = 'Doe');
-- same works with player_season_passing_stats_view, player_season_defense_stats_view, player_season_receiving_stats_view

-- Top 10 Rushers by Total Yards in a given season (eg. 2023)
SELECT P.`first_name`, P.`last_name`, PS.`total yards` AS total_yards
FROM `player_season_rushing_stats_view` AS PS
    JOIN `players` AS P 
    ON PS.`player_id` = P.`id`
WHERE PS.`season` = 2023
ORDER BY PS.`total yards` DESC
LIMIT 10;
-- Top 10 Passers by Total Yards for a given season (eg. 2023)
SELECT T.`name`, TS.`wins`
FROM `current_year_team_performance` AS TS
JOIN `teams` AS T ON TS.`name` = T.`name`
WHERE TS.`season` = 2023
ORDER BY TS.`wins` DESC;

-- Teams with the Most Wins in a given season (eg. 2023)
SELECT T.`name`, TS.`wins`
FROM `current_year_team_performance` AS TS
    JOIN `teams` AS T 
    ON TS.`name` = T.`name`
WHERE TS.`season` = 2023
ORDER BY TS.`wins` DESC;

-- Players without Teams (Free Agents)
SELECT P.`first_name`, P.`last_name`, P.`position`
FROM `free_agents_view` AS P;

-- List of Currently Injured Players
SELECT P.`first_name`, P.`last_name`, P.`team_name`, P.`designation`, P.`description`
FROM `injured_players_view` AS P;

-- Coaches and Their Current Teams
SELECT C.`first_name`, C.`last_name`, T.`team_name`, TC.`position`
FROM `current_coaches_teams_view` AS C;

-- Games for a Specific Team (eg. team code SEA for Seattle Seahawks) for a given season (2023)
SELECT * FROM `team_games_per_season`
WHERE `team_name` = 'Dallas Cowboys' AND `season` = 2023;

-- Submitting Game Results 
-- (eg. Dallas Cowboys (DAL) played against the New York Giants (NYG) on October 3rd, 2023, from 8:00 PM to 11:00 PM at the "Cowboys Stadium". 
-- The Cowboys scored 28 while the Giants scored 24. This was not a playoff, conference championship, or Super Bowl game)
CALL `add_game_results`('2023-10-03 20:00:00', '2023-10-03 23:00:00', 'Cowboys Stadium', 'DAL', 'NYG', 28, 24, 0, 0, 0);

-- Adding a New Player to a Team 
-- (eg. add a player named John Doe to the Dallas Cowboys (DAL) effective from September 1st, 2023)
CALL `add_player_to_team`('John', 'Doe', 'DAL', '2023-09-01');

-- Updating Player Injury Status 
-- (eg. If John Doe was injured on October 10th, 2023, with a "Questionable" designation due to a "Sprained Ankle")
CALL `add_player_injury`('John', 'Doe', '2023-10-10', 'Q', 'Sprained Ankle');

-- Marking Player as Recovered
-- (eg. To mark John Doe as recovered from his injury on October 20th, 2023)
CALL `mark_player_recovered`('John', 'Doe', '2023-10-20');


