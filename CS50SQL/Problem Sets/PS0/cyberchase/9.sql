SELECT count("title") as "Episodes in first 6 yrs"
FROM "episodes"
WHERE "air_date" BETWEEN "2002-01-01" AND "2007-12-31";
