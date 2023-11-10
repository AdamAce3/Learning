SELECT P."first_name", P."last_name", (S."salary"/Pr."H") as 'dollars per hit'
FROM "players" P
    JOIN "salaries" S
    ON P."id" = S."player_id"
    JOIN "performances" Pr
    ON P."id" = Pr."player_id" AND
        S."year" = Pr."year"
WHERE S."year" = 2001
    AND Pr."H" > 0
ORDER BY "dollars per hit", P."first_name", P."last_name"
LIMIT 10;

