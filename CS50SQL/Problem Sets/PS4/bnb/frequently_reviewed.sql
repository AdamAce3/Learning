CREATE VIEW "frequently_reviewed" AS
    SELECT L."id", L."property_type", L."host_name", count(R."id") as 'reviews'
    FROM "reviews" R
        JOIN "listings" L
        ON R."listing_id" = L."id"
    GROUP BY L."id"
    ORDER BY "reviews" DESC, "property_type", "host_name"
    LIMIT 100;