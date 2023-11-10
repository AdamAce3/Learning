SELECT D."name", E."per_pupil_expenditure", SE."exemplary"
FROM "districts" D
    JOIN "expenditures" E
    ON D."id" = E."district_id"
    JOIN "staff_evaluations" SE
    ON D."id" = SE."district_id"
WHERE D."type" = "Public School District"
    AND E."per_pupil_expenditure" > (SELECT avg("per_pupil_expenditure")
                                        FROM "expenditures")
    AND SE."exemplary" > (SELECT avg("exemplary")
                            FROM "staff_evaluations")
ORDER BY SE."exemplary" DESC, E."per_pupil_expenditure" DESC;

