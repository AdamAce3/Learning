--Top 5 prints' english_title and artist with the highest entropy
--with higher than average brightness and constrast
SELECT "english_title" AS "Top 5 Prints with Highest Entropy", "artist"
FROM "views"
WHERE "brightness" > (SELECT avg("brightness") FROM "views")
    AND "constrast" > (SELECT avg("contrast") FROM "views")
ORDER BY "entropy" DESC
LIMIT 5;