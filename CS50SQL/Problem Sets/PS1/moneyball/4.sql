SELECT P."first_name", P."last_name", S."salary"
FROM "players" P
    JOIN "salaries" S
    ON P."id" = S."player_id"
WHERE S."year" = 2001
ORDER BY S."salary", P."first_name", P."last_name", P."id"
LIMIT 50;