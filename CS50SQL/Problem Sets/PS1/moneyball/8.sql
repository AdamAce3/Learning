SELECT S."salary"
FROM "salaries" S
    JOIN
    "performances" Pf
    ON S."player_id" = Pf."player_id"
        AND S."year" = Pf."year"
WHERE S."year" = 2001
ORDER BY Pf."HR" DESC
LIMIT 1;

