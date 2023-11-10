SELECT D."name", E."per_pupil_expenditure"
FROM "districts" D
    JOIN "expenditures" E
    ON D."id" = E."district_id"
WHERE D."type" = 'Public School District'
ORDER BY E."per_pupil_expenditure" DESC
LIMIT 10;