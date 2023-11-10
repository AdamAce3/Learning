SELECT "year", round(avg("salary"),2) as "avarage salary"
FROM "salaries"
GROUP BY "year"
ORDER BY "year" DESC;
