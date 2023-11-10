SELECT "first_name", "last_name", "debut"
FROM "players"
WHERE "birth_city" is "Pittsburgh"
    AND "birth_state" is "PA"
ORDER BY "debut" DESC, "first_name", "last_name";