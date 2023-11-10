SELECT S."name"
FROM "schools" S
    JOIN "districts" D
    ON S."district_id" = D."id"
WHERE D."name" = "Cambridge";