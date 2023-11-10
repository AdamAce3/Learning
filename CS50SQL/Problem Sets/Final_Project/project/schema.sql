-- nfl_stats DB

-- Player table
CREATE TABLE IF NOT EXISTS `players` (
    `id` MEDIUMINT UNSIGNED AUTO_INCREMENT,
    `first_name` VARCHAR(32) NOT NULL,
    `last_name` VARCHAR(32) NOT NULL,
    `school` VARCHAR(64) NOT NULL,
    `jersey_num` TINYINT UNSIGNED,
    `DOB` DATE NOT NULL,
    `position` ENUM('QB','RB','FB','LT','LG','C','RG','RT','WR','TE','DE','DT','LB','CB','SS','FS','K','P') NOT NULL,
    `height_in` TINYINT,
    `weight_lbs` DECIMAL(4,1),
    PRIMARY KEY (`id`)
);

-- Player injury info
CREATE TABLE IF NOT EXISTS `injuries` (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `player_id` MEDIUMINT UNSIGNED,
    `date` DATE NOT NULL,
    `designation` ENUM('Q','D','O','SUS','IR','PUP') NOT NULL,
    `description` TEXT NOT NULL,
    `end_date` DATE DEFAULT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`player_id`) REFERENCES `players`(`id`)
);

-- Teams table
CREATE TABLE IF NOT EXISTS `teams` (
    `id` TINYINT UNSIGNED AUTO_INCREMENT, 
    `name` VARCHAR(16) NOT NULL UNIQUE,
    `code` CHAR(3) NOT NULL UNIQUE,
    `location` VARCHAR(32) NOT NULL,
    `home_stadium` VARCHAR(32) NOT NULL,
    `founded` YEAR NOT NULL,
    `owner` VARCHAR(32),
    PRIMARY KEY (`id`)
);

-- Associative Entity between Players and Teams
CREATE TABLE IF NOT EXISTS `players_teams` (
    `player_id` MEDIUMINT UNSIGNED,
    `team_id` TINYINT UNSIGNED,
    `start_date` DATE NOT NULL,
    `end_date` DATE,
    `end_reason` VARCHAR(16),
    PRIMARY KEY (`player_id`,`team_id`),
    FOREIGN KEY (`player_id`) REFERENCES `players`(`id`),
    FOREIGN KEY (`team_id`) REFERENCES `teams`(`id`)
);

-- Overall Team statistics by seaon
CREATE TABLE IF NOT EXISTS `team_stats` (
    `id` MEDIUMINT UNSIGNED AUTO_INCREMENT,
    `team_id` TINYINT UNSIGNED,
    `season` YEAR NOT NULL,
    `conference` ENUM('AFC','NFC') NOT NULL,
    `division` ENUM('East','West','North','South') NOT NULL,
    `wins` TINYINT UNSIGNED DEFAULT 0,
    `ties` TINYINT UNSIGNED DEFAULT 0,
    `losses` TINYINT UNSIGNED DEFAULT 0,
    `playoff_seat` TINYINT UNSIGNED,
    `made_conf_champ` TINYINT UNSIGNED DEFAULT 0,
    `conf_champ_W` TINYINT UNSIGNED DEFAULT 0,
    `superbowl_W` TINYINT UNSIGNED DEFAULT 0,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`team_id`) REFERENCES `teams`(`id`)
);

-- Coaches table
CREATE TABLE IF NOT EXISTS `coaches` (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `first_name` VARCHAR(32) NOT NULL,
    `last_name` VARCHAR(32) NOT NULL,
    PRIMARY KEY (`id`)
);

-- Tenure Coaches and Teams (Note: tenure resets if a coach leaves and later rejoins a team)
CREATE TABLE IF NOT EXISTS `teams_coaches` (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `team_id` TINYINT UNSIGNED,
    `coach_id` INT UNSIGNED,
    `start_date` DATE NOT NULL,
    `position` VARCHAR(32) NOT NULL,
    `end_date` DATE,
    `end_reason` VARCHAR(16),
    PRIMARY KEY (`id`),
    FOREIGN KEY (`team_id`) REFERENCES `teams`(`id`),
    FOREIGN KEY (`coach_id`) REFERENCES `coaches`(`id`)
);

-- Games Table
CREATE TABLE IF NOT EXISTS `games` (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `start_datetime` TIMESTAMP(0) NOT NULL,
    `end_datetime` TIMESTAMP(0) NOT NULL,
    `location` VARCHAR(32) NOT NULL,
    `home_team_id` TINYINT UNSIGNED,
    `away_team_id` TINYINT UNSIGNED,
    `home_score` TINYINT NOT NULL,
    `away_score` TINYINT NOT NULL,
    `playoff` TINYINT DEFAULT 0,
    `conf_champ` TINYINT DEFAULT 0,
    `superbowl` TINYINT DEFAULT 0,
    CHECK(`away_team_id`<>`home_team_id`),
    PRIMARY KEY (`id`),
    FOREIGN KEY (`home_team_id`) REFERENCES `teams`(`id`),
    FOREIGN KEY (`away_team_id`) REFERENCES `teams`(`id`)
);

-- (Parent) Player Game Stats Table
CREATE TABLE IF NOT EXISTS `player_game_stats` (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `game_id` INT UNSIGNED,
    `player_id` MEDIUMINT UNSIGNED,
    `active` TINYINT NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`game_id`) REFERENCES `games`(`id`),
    FOREIGN KEY (`player_id`) REFERENCES `players`(`id`)
);

-- (Children) Stats Per Game: Rushing, Passing, Defense, Receiving
-- RUSHING
CREATE TABLE IF NOT EXISTS `player_game_stats_rushing` (
    `game_stat_id` INT UNSIGNED,
    `yards` SMALLINT UNSIGNED DEFAULT 0,
    `carries` SMALLINT UNSIGNED DEFAULT 0,
    `TDs` TINYINT UNSIGNED DEFAULT 0,
    PRIMARY KEY (`game_stat_id`),
    FOREIGN KEY(`game_stat_id`) REFERENCES `player_game_stats`(`id`)
);
-- PASSING
CREATE TABLE IF NOT EXISTS `player_game_stats_passing` (
    `game_stat_id` INT UNSIGNED,
    `attempts` SMALLINT UNSIGNED DEFAULT 0,
    `completions` SMALLINT UNSIGNED DEFAULT 0,
    `yards` SMALLINT UNSIGNED DEFAULT 0,
    `TDs` TINYINT UNSIGNED DEFAULT 0,
    `interceptions` TINYINT UNSIGNED DEFAULT 0,
    PRIMARY KEY (`game_stat_id`),
    FOREIGN KEY(`game_stat_id`) REFERENCES `player_game_stats`(`id`)
);
-- DEFENSE
CREATE TABLE IF NOT EXISTS `player_game_stats_defense` (
    `game_stat_id` INT UNSIGNED,
    `total_tackles` TINYINT UNSIGNED DEFAULT 0,
    `solo_tackles` TINYINT UNSIGNED DEFAULT 0,
    `TFL` TINYINT UNSIGNED DEFAULT 0,
    `sacks` TINYINT UNSIGNED DEFAULT 0,
    `qb_hits` TINYINT UNSIGNED DEFAULT 0,
    `pass_deflections` TINYINT UNSIGNED DEFAULT 0,
    `interceptions` TINYINT UNSIGNED DEFAULT 0,
    `TDs` TINYINT UNSIGNED DEFAULT 0,
    PRIMARY KEY (`game_stat_id`),
    FOREIGN KEY(`game_stat_id`) REFERENCES `player_game_stats`(`id`)
);
-- RECEIVING
CREATE TABLE IF NOT EXISTS `player_game_stats_receiving` (
    `game_stat_id` INT UNSIGNED,
    `targets` TINYINT UNSIGNED DEFAULT 0,
    `receptions` TINYINT UNSIGNED DEFAULT 0,
    `TDs` TINYINT UNSIGNED DEFAULT 0,
    PRIMARY KEY (`game_stat_id`),
    FOREIGN KEY(`game_stat_id`) REFERENCES `player_game_stats`(`id`)
);


-- *Views*

-- Active players
CREATE IF NOT EXITS `active_players` AS
SELECT P.*
FROM `players` P
WHERE EXISTS (
    SELECT 1 
    FROM `players_teams` PT 
    WHERE PT.`player_id` = P.`id` AND PT.`end_date` IS NULL
);

-- Players on each team ordered by team, then player first name, then last name
CREATE VIEW IF NOT EXISTS `current_players_by_team` AS
SELECT T.`name`, P.`first_name`, P.`last_name`
FROM `teams` T
    JOIN `players_teams` PT 
    ON T.`id`=PT.`team_id`
    JOIN `players` P
    ON PT.`player_id`=P.`id`
WHERE PT.`end_date` IS NOT NULL
ORDER BY T.`name`,P.`first_name`, P.`last_name`;

-- Player Season stats
-- RUSHING
CREATE VIEW IF NOT EXISTS `player_season_rushing_stats_view` AS
SELECT PGS.`player_id`,
    YEAR(G.`start_datetime`) AS `season`,
    sum(PGSR.`yards`) AS `total yards`,
    sum(PGSR.`carries`) AS `total carries`,
    sum(PGSR.`TDs`) AS `total TDs`
FROM `player_game_stats_rushing` PGSR
    JOIN `player_game_stats` PGS
    ON PGSR.`game_stat_id` = PGS.`id`
    JOIN `games` G
    ON PGS.`game_id` = G.`id`
GROUP BY PGS.`player_id`,`season`;
-- PASSING
CREATE VIEW IF NOT EXISTS `player_season_passing_stats_view` AS
SELECT PGS.`player_id`,
    YEAR(G.`start_datetime`) AS `season`,
    SUM(PGSP.`attempts`) AS `total_attempts`,
    SUM(PGSP.`completions`) AS `total_completions`,
    SUM(PGSP.`yards`) AS `total_yards`,
    SUM(PGSP.`TDs`) AS `total_TDs`,
    SUM(PGSP.`interceptions`) AS `total_interceptions`
FROM `player_game_stats_passing` PGSP
    JOIN `player_game_stats` PGS
    ON PGSP.`game_stat_id` = PGS.`id`
    JOIN `games` G
    ON PGS.`game_id` = G.`id`
GROUP BY PGS.`player_id`, `season`;
-- DEFENSE
CREATE VIEW IF NOT EXISTS `player_season_defense_stats_view` AS
SELECT PGS.`player_id`,
    YEAR(G.`start_datetime`) AS `season`,
    SUM(PGSD.`total_tackles`) AS `total_tackles`,
    SUM(PGSD.`solo_tackles`) AS `total_solo_tackles`,
    SUM(PGSD.`TFL`) AS `total_TFL`,
    SUM(PGSD.`sacks`) AS `total_sacks`,
    SUM(PGSD.`qb_hits`) AS `total_qb_hits`,
    SUM(PGSD.`pass_deflections`) AS `total_pass_deflections`,
    SUM(PGSD.`interceptions`) AS `total_interceptions`,
    SUM(PGSD.`TDs`) AS `total_TDs`
FROM `player_game_stats_defense` PGSD
    JOIN `player_game_stats` PGS
    ON PGSD.`game_stat_id` = PGS.`id`
    JOIN `games` G
    ON PGS.`game_id` = G.`id`
GROUP BY PGS.`player_id`, `season`;
-- RECEIVING
CREATE VIEW IF NOT EXISTS `player_season_receiving_stats_view` AS
SELECT PGS.`player_id`,
    YEAR(G.`start_datetime`) AS `season`,
    SUM(PGSR.`targets`) AS `total_targets`,
    SUM(PGSR.`receptions`) AS `total_receptions`,
    SUM(PGSR.`TDs`) AS `total_TDs`
FROM `player_game_stats_receiving` PGSR
    JOIN `player_game_stats` PGS
    ON PGSR.`game_stat_id` = PGS.`id`
    JOIN `games` G
    ON PGS.`game_id` = G.`id`
GROUP BY PGS.`player_id`, `season`;

-- Player Career stats
-- RUSHING
CREATE VIEW IF NOT EXISTS `player_career_rushing_stats_view` AS
SELECT PGS.`player_id`,
    sum(PGSR.`yards`) AS `total yards`,
    sum(PGSR.`carries`) AS `total carries`,
    sum(PGSR.`TDs`) AS `total TDs`
FROM `player_game_stats_rushing` PGSR
    JOIN `player_game_stats` PGS
    ON PGSR.`game_stat_id` = PGS.`id`
GROUP BY PGS.`player_id`;
-- PASSING
CREATE VIEW IF NOT EXISTS `player_career_passing_stats_view` AS
SELECT PGS.`player_id`,
    SUM(PGSP.`attempts`) AS `total_attempts`,
    SUM(PGSP.`completions`) AS `total_completions`,
    SUM(PGSP.`yards`) AS `total_yards`,
    SUM(PGSP.`TDs`) AS `total_TDs`,
    SUM(PGSP.`interceptions`) AS `total_interceptions`
FROM `player_game_stats_passing` PGSP
    JOIN `player_game_stats` PGS
    ON PGSP.`game_stat_id` = PGS.`id`
GROUP BY PGS.`player_id`;
-- DEFENSE
CREATE VIEW IF NOT EXISTS `player_career_defense_stats_view` AS
SELECT PGS.`player_id`,
    SUM(PGSD.`total_tackles`) AS `total_tackles`,
    SUM(PGSD.`solo_tackles`) AS `total_solo_tackles`,
    SUM(PGSD.`TFL`) AS `total_TFL`,
    SUM(PGSD.`sacks`) AS `total_sacks`,
    SUM(PGSD.`qb_hits`) AS `total_qb_hits`,
    SUM(PGSD.`pass_deflections`) AS `total_pass_deflections`,
    SUM(PGSD.`interceptions`) AS `total_interceptions`,
    SUM(PGSD.`TDs`) AS `total_TDs`
FROM `player_game_stats_defense` PGSD
    JOIN `player_game_stats` PGS
    ON PGSD.`game_stat_id` = PGS.`id`
GROUP BY PGS.`player_id`;
-- RECEIVING
CREATE VIEW IF NOT EXISTS `player_career_receiving_stats_view` AS
SELECT PGS.`player_id`,
    SUM(PGSR.`targets`) AS `total_targets`,
    SUM(PGSR.`receptions`) AS `total_receptions`,
    SUM(PGSR.`TDs`) AS `total_TDs`
FROM `player_game_stats_receiving` PGSR
    JOIN `player_game_stats` PGS
    ON PGSR.`game_stat_id` = PGS.`id`
GROUP BY PGS.`player_id`;

-- Games per team per year
CREATE VIEW IF NOT EXISTS `team_games_per_season` AS
SELECT 
    T.`name` AS team_name,
    CASE 
        WHEN MONTH(G.`start_datetime`) BETWEEN 9 AND 12 THEN YEAR(G.`start_datetime`)
        ELSE YEAR(G.`start_datetime`) - 1
    END AS season,
    G.`start_datetime`,
    G.`end_datetime`,
    G.`location`,
    IF (T.`id` = G.`home_team_id`, 
       (SELECT `name` FROM `teams` WHERE `id` = G.`away_team_id`), 
       (SELECT `name` FROM `teams` WHERE `id` = G.`home_team_id`)) AS opponent,
    G.`home_score`,
    G.`away_score`,
    CASE 
        WHEN T.`id` = G.`home_team_id` THEN G.`home_score`
        ELSE G.`away_score`
    END AS team_score,
    CASE 
        WHEN T.`id` = G.`home_team_id` THEN G.`away_score`
        ELSE G.`home_score`
    END AS opponent_score,
    G.`playoff`,
    G.`conf_champ`,
    G.`superbowl`
FROM 
    `games` G
    JOIN `teams` T
    ON T.`id` = G.`home_team_id` OR T.`id` = G.`away_team_id`
ORDER BY 
    T.`name`, season, G.`start_datetime`;


-- Currently Injured Players
CREATE OR REPLACE VIEW `injured_players_view` AS
SELECT P.`first_name`, P.`last_name`, T.`name` AS `team_name`, I.`designation`, I.`description`
FROM `injuries` I
    JOIN `players` P 
    ON I.`player_id` = P.`id`
    LEFT JOIN `players_teams` PT 
    ON P.`id` = PT.`player_id` AND PT.`end_date` IS NULL
    LEFT JOIN `teams` T 
    ON PT.`team_id` = T.`id`
WHERE I.`end_date` IS NULL
ORDER BY T.`name`, P.`first_name`, P.`last_name`;

-- Players Without Current Teams (free agents)
CREATE VIEW IF NOT EXISTS `free_agents_view` AS
SELECT P.`first_name`, P.`last_name`, P.`position`
    FROM `players` P
    LEFT JOIN `players_teams` PT 
    ON P.`id` = PT.`player_id` AND PT.`end_date` IS NULL
WHERE PT.`team_id` IS NULL
ORDER BY P.`position`, P.`first_name`, P.`last_name`;

-- Coaches and Their Current Teams
CREATE VIEW IF NOT EXISTS `current_coaches_teams_view` AS
SELECT C.`first_name`, C.`last_name`, T.`name` AS `team_name`, TC.`position`
FROM `teams_coaches` TC
    JOIN `coaches` C ON TC.`coach_id` = C.`id`
    JOIN `teams` T ON TC.`team_id` = T.`id`
WHERE TC.`end_date` IS NULL
ORDER BY T.`name`, TC.`position`;

-- Teams' Performance in the Current Year
CREATE VIEW IF NOT EXISTS `current_year_team_performance` AS
SELECT T.`name`, TS.`wins`, TS.`ties`, TS.`losses`, TS.`playoff_seat`, TS.`made_conf_champ`, TS.`conf_champ_W`, TS.`superbowl_W`
FROM `team_stats` TS
    JOIN `teams` T ON TS.`team_id` = T.`id`
WHERE TS.`season` = CASE 
                      WHEN MONTH(CURDATE()) BETWEEN 1 AND 8 THEN YEAR(CURDATE()) - 1 
                      ELSE YEAR(CURDATE())
                    END
ORDER BY TS.`wins` DESC, TS.`ties` DESC, TS.`losses`, T.`name`;

-- *Procedures*
DELIMITER //

-- Submitting game results
CREATE PROCEDURE IF NOT EXISTS `add_game_results`(IN start_datetime TIMESTAMP(0),
                                    IN end_datetime TIMESTAMP(0),
                                    IN location VARCHAR(32),
                                    IN home_team_code CHAR(3),
                                    IN away_team_code CHAR(3),
                                    IN home_score TINYINT,
                                    IN away_score TINYINT,
                                    IN playoff TINYINT,
                                    IN conf_champ TINYINT,
                                    IN superbowl TINYINT)
BEGIN
INSERT INTO `games`(`start_datetime`,`end_datetime`,`location`,`home_team_id`,`away_team_id`,`home_score`,`away_score`,`playoff`,`conf_champ`,`superbowl`)
VALUES (start_datetime,end_datetime,location,(SELECT `id` FROM `teams` WHERE `code`=home_team_code),(SELECT `id` FROM `teams` WHERE `code`=away_team_code),home_score,away_score,playoff,conf_champ,superbowl);
-- updating team_stats stats
IF home_score>away_score THEN
UPDATE `team_stats` SET `wins`=`wins`+1 WHERE `team_id`=(SELECT `id` FROM `teams` WHERE `code`=home_team_code) AND `season` = YEAR(start_datetime);
UPDATE `team_stats` SET `losses`=`losses`+1 WHERE `team_id`=(SELECT `id` FROM `teams` WHERE `code`=away_team_code) AND `season` = YEAR(start_datetime);
ELSEIF home_score<away_score THEN
UPDATE `team_stats` SET `wins`=`wins`+1 WHERE `team_id`=(SELECT `id` FROM `teams` WHERE `code`=away_team_code) AND `season` = YEAR(start_datetime);
UPDATE `team_stats` SET `losses`=`losses`+1 WHERE `team_id`=(SELECT `id` FROM `teams` WHERE `code`=home_team_code) AND `season` = YEAR(start_datetime);
ELSE 
UPDATE `team_stats` SET `ties`=`ties`+1 WHERE `team_id` IN (SELECT `id` FROM `teams` WHERE `code`=home_team_code OR `code`=away_team_code) AND `season` = YEAR(start_datetime);
END IF;
-- updating conf champ & superbowl attendance/win(W) in team_stats
IF conf_champ = 1 THEN
UPDATE `team_stats` SET `made_conf_champ`=`made_conf_champ`+1 WHERE `team_id` IN (SELECT `id` FROM `teams` WHERE `code`=home_team_code OR `code`=away_team_code) AND `season` = YEAR(start_datetime);
END IF;
IF conf_champ = 1 AND home_score>away_score THEN
UPDATE `team_stats` SET `conf_champ_W`=`conf_champ_W`+1 WHERE `team_id`=(SELECT `id` FROM `teams` WHERE `code`=home_team_code) AND `season` = YEAR(start_datetime);
ELSEIF conf_champ = 1 AND home_score<away_score THEN
UPDATE `team_stats` SET `conf_champ_W`=`conf_champ_W`+1 WHERE `team_id`=(SELECT `id` FROM `teams` WHERE `code`=away_team_code) AND `season` = YEAR(start_datetime);
END IF;
IF superbowl = 1 AND home_score>away_score THEN
UPDATE `team_stats` SET `superbowl_W`=`superbowl_W`+1 WHERE `team_id`=(SELECT `id` FROM `teams` WHERE `code`=home_team_code) AND `season` = YEAR(start_datetime);
ELSEIF conf_champ = 1 AND home_score<away_score THEN
UPDATE `team_stats` SET `superbowl_W`=`superbowl_W`+1 WHERE `team_id`=(SELECT `id` FROM `teams` WHERE `code`=away_team_code) AND `season` = YEAR(start_datetime);
END IF;
END//

-- Add a New Player to a Team
CREATE PROCEDURE IF NOT EXISTS `add_player_to_team`(IN player_first_name VARCHAR(32),
                                      IN player_last_name VARCHAR(32),
                                      IN team_code CHAR(3),
                                      IN start_date DATE)
BEGIN
    DECLARE _player_id MEDIUMINT UNSIGNED;
    DECLARE _team_id TINYINT UNSIGNED;
    -- Get player_id based on name
    SELECT `id` INTO _player_id FROM `players` WHERE `first_name` = player_first_name AND `last_name` = player_last_name;
    -- Get team_id based on code
    SELECT `id` INTO _team_id FROM `teams` WHERE `code` = team_code;
    -- Insert into players_teams
    INSERT INTO `players_teams`(`player_id`, `team_id`, `start_date`) VALUES (_player_id, _team_id, start_date);
END //

-- Update Player Injury Status
CREATE PROCEDURE IF NOT EXISTS `add_player_injury`(IN first_name VARCHAR(32),
                                        IN last_name VARCHAR(32),
                                        IN date DATE,
                                        IN designation ENUM('Q','D','O','SUS','IR','PUP'),
                                        IN description TEXT)
BEGIN
    DECLARE _player_id MEDIUMINT UNSIGNED;
    -- Get player_id based on name
    SELECT `id` INTO _player_id FROM `players` WHERE `first_name` = first_name AND `last_name` = last_name;
    -- Update injury status
    INSERT INTO `injuries`(`player_id`, `date`, `designation`, `description`) VALUES (_player_id, date, designation, description);
END //

-- Mark Player Recovered
CREATE PROCEDURE IF NOT EXISTS `mark_player_recovered`(IN first_name VARCHAR(32),
                                                       IN last_name VARCHAR(32),
                                                       IN recovered_date DATE)
BEGIN
    DECLARE _player_id MEDIUMINT UNSIGNED;
    -- Get player_id based on name
    SELECT `id` INTO _player_id FROM `players` WHERE `first_name` = first_name AND `last_name` = last_name;
    
    -- Update the latest injury's end_date to mark recovery
    UPDATE `injuries` 
    SET `end_date` = recovered_date 
    WHERE `player_id` = _player_id AND `end_date` IS NULL;
END //

DELIMITER ;

-- *Indexes*
-- Indexes for `players_teams`
CREATE INDEX IF NOT EXISTS `players_teams_active_index` ON players_teams(player_id, end_date);

-- Index for `injuries`
CREATE INDEX IF NOT EXISTS `injuries_player_date_index` ON injuries(player_id, date);

-- Indexes for `games`
CREATE INDEX IF NOT EXISTS `games_start_datetime_index` ON games(start_datetime);
CREATE INDEX IF NOT EXISTS `games_end_datetime_index` ON games(end_datetime);
CREATE INDEX IF NOT EXISTS `games_home_team_id_index` ON games(home_team_id);
CREATE INDEX IF NOT EXISTS `games_away_team_id_index` ON games(away_team_id);
