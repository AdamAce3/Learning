SELECT D."name"
FROM "districts" D
    JOIN "expenditures" E
    ON D."id" = E."district_id"
GROUP BY D."name"
HAVING sum("pupils") = (SELECT min("num_pupils") 
                        FROM (SELECT sum(E."pupils") as "num_pupils"
                                FROM "districts" D
                                    JOIN "expenditures" E
                                    ON D."id" = E."district_id"
                                GROUP BY D."name"));
