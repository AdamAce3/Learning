SELECT count("title") as "Episodes in last 6 yrs"
FROM "episodes"
WHERE "air_date" between "2018-01-01" AND "2023-12-31";