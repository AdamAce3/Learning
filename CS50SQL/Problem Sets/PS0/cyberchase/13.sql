--Episode titles starts with T that don't begin with "The"
SELECT "title"
FROM "episodes"
WHERE "title" like "T%"
    AND "title" not LIKE "The%";