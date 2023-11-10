SELECT "english_title" as "5 Brightest Prints by Hiroshige"
FROM "views"
WHERE "artist" = "Hiroshige"
ORDER BY "brightness" DESC
LIMIT 5;