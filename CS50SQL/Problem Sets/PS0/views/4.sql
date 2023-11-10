SELECT count("print_number") AS "Prints by Hiroshige with 'Eastern Capital'"
FROM "views"
WHERE "artist" = "Hiroshige"
    AND "english_title" LIKE "%Eastern Capital%";