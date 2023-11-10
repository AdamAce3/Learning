SELECT round(avg("height"),2) AS "Average Height", round(avg("weight"),2) as "Average Weight"
FROM "players"
WHERE "debut" >= '2000-01-01'