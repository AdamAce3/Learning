CREATE VIEW "message" AS
    SELECT "phrase"    
    FROM (SELECT '1' AS "line", substr("sentence", 98, 4) AS "phrase"
        FROM "sentences"
        WHERE "id" = 14
        UNION
        SELECT '2', substr("sentence", 3, 5)
        FROM "sentences"
        WHERE "id" = 114
        UNION
        SELECT '3', substr("sentence", 72, 9)
        FROM "sentences"
        WHERE "id" = 618
        UNION
        SELECT '4', substr("sentence", 7, 3)
        FROM "sentences"
        WHERE "id" = 630
        UNION
        SELECT '5', substr("sentence", 12, 5)
        FROM "sentences"
        WHERE "id" = 932
        UNION
        SELECT '6', substr("sentence", 50, 7)
        FROM "sentences"
        WHERE "id" = 2230
        UNION
        SELECT '7', substr("sentence", 44, 10)
        FROM "sentences"
        WHERE "id" = 2346
        UNION
        SELECT '8', substr("sentence", 14, 5)
        FROM "sentences"
        WHERE "id" = 3041)
    ORDER BY "line";

-- WITH SubstrDetails AS (
--     SELECT 14 AS id, 98 AS start, 4 AS length, '1' AS line
--     UNION ALL SELECT 114, 3, 5, '2'
--     UNION ALL SELECT 618, 72, 9, '3'
--     UNION ALL SELECT 630, 7, 3, '4'
--     UNION ALL SELECT 932, 12, 5, '5'
--     UNION ALL SELECT 2230, 50, 7, '6'
--     UNION ALL SELECT 2346, 44, 10, '7'
--     UNION ALL SELECT 3041, 14, 5, '8'
-- )
-- SELECT substr(s.sentence, d.start, d.length) AS "phrase"
-- FROM SubstrDetails d
-- JOIN "sentences" s ON d.id = s.id
-- ORDER BY d.line;