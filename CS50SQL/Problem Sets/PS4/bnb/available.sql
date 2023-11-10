CREATE VIEW "available" AS
    SELECT L."id", L."property_type", L."host_name", A."date"
    FROM "listings" L
        JOIN "availabilities" A
        ON L."id" = "listing_id";