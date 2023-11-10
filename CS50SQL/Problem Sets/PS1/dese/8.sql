SELECT D."name", E."pupils"
FROM "districts" D
    JOIN "expenditures" E
    ON D."id" = E."district_id"
GROUP BY D."name";