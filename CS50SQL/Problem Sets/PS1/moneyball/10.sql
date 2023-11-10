SELECT P."first_name", P."last_name", S."salary", Pf."HR", S."year"
FROM "salaries" S
    JOIN "performances" Pf
    ON S."player_id" = Pf."player_id"
        AND S."year" = Pf."year"
    JOIN "players" P
    ON S."player_id" = P."id"
ORDER BY S."player_id", S."year" DESC, Pf."HR" DESC, S."salary" DESC;
