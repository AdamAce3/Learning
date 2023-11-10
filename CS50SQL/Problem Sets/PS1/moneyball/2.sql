SELECT S."year", S."salary"
FROM "salaries" S
    JOIN "players" P
    ON S."player_id" = P."id"
WHERE P."first_name"||" "||P."last_name" = 'Cal Ripken'
ORDER BY "year" DESC;