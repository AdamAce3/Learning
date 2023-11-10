SELECT count("print_number") as "Prints by Hokusai with 'Fuji'"
FROM "views"
WHERE "artist" = "Hokusai"
    AND "english_title" LIKE "%Fuji%";