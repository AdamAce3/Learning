SELECT * FROM (SELECT P."first_name", P."last_name"
                FROM "players" P
                    JOIN "salaries" S
                    ON P."id" = S."player_id"
                    JOIN "performances" Pr
                    ON P."id" = Pr."player_id" AND
                        S."year" = Pr."year"
                WHERE S."year" = 2001
                    AND Pr."H" > 0
                ORDER BY (S."salary"/Pr."H")
                LIMIT 10)
INTERSECT
SELECT * FROM (SELECT P."first_name", P."last_name"
                FROM "players" P
                    JOIN "salaries" S
                    ON P."id" = S."player_id"
                    JOIN "performances" Pr
                    ON P."id" = Pr."player_id" AND
                        S."year" = Pr."year"
                WHERE S."year" = 2001
                    AND Pr."RBI" > 0
                ORDER BY (S."salary"/Pr."RBI")
                LIMIT 10)
ORDER BY "last_name";