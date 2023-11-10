SELECT T."name", sum(Pf."H") as 'total hits'
FROM "performances" Pf
    JOIN "teams" T
    ON Pf."team_id" = T."id"
WHERE Pf."year" = 2001
    AND T."name" != 'Oakland Athletics'
GROUP BY T."name"
ORDER BY "total hits" DESC
LIMIT 5;