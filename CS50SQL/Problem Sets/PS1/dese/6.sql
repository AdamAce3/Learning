SELECT S."name"
FROM "graduation_rates" GR
    JOIN "schools" S
    ON GR."school_id" = S."id"
WHERE GR."graduated" = 100;