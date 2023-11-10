SELECT DISTINCT T."name"
FROM "teams" T
    JOIN "performances" Pf
    ON T."id" = Pf."team_id"
    JOIN "players" P
    ON Pf."player_id" = P."id"
WHERE P."first_name"||' '||P."last_name" = 'Satchel Paige';