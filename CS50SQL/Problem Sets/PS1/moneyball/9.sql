SELECT T."name", round(avg(S."salary"),2) as "average salary"
FROM "salaries" S
    JOIN "teams" T
    ON S."team_id" = T."id"
WHERE S."year" = 2001
--    AND T."name" != "Oakland Athletics"
GROUP BY T."name"
ORDER BY "average salary"
LIMIT 5;
