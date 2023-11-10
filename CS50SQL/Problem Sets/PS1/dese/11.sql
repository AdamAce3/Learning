SELECT S."name" as "school_name", E."per_pupil_expenditure", GR."graduated"
FROM "schools" S
    JOIN "expenditures" E
    ON S."district_id" = E."district_id"
    JOIN "graduation_rates" GR
    ON S."id" = GR."school_id"
ORDER BY E."per_pupil_expenditure" DESC, "school_name";