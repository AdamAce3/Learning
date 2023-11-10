--Top 5 tallest players' names, height, and weight since 2020, ordered by height from tallest to shortest
SELECT "first_name", "last_name", "height", "weight"
FROM "players"
WHERE "debut" >= '2020-01-01'
ORDER BY "height" DESC
LIMIT 5;