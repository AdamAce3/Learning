-- Exploring if number of pupils is associated with an above average unsatisfactory ratings for each district
-- Return three columns: district name, number of pupils, unsatisfactory rating
-- Ordered by unsatisfactory ratings (high to low), then by number of pupils (high to low)
SELECT D."name", E."pupils", SE."unsatisfactory"
FROM "districts" D
    JOIN "expenditures" E
    ON D."id" = E."district_id"
    JOIN "staff_evaluations" SE
    ON D."id" = SE."district_id"
WHERE SE."unsatisfactory" > (SELECT avg("unsatisfactory") 
                                FROM "staff_evaluations")
ORDER BY SE."unsatisfactory" DESC, E."pupils" DESC;