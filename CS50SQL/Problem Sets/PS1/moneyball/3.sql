SELECT Pf."year", Pf."HR"
FROM "performances" Pf
    JOIN
    "players" P
    ON Pf."player_id" = P."id"
WHERE P."first_name"||" "||P."last_name" = 'Ken Griffey'
    AND P."birth_year" = 1969
ORDER BY Pf."year" DESC;