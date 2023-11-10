
-- *** The Lost Letter ***

-- Checking if shipping address is correct
SELECT P."id", Afrom."address" as "from_address_name", Ato."address" as "to_address_name", "contents"
FROM "packages" P
    JOIN "addresses" Afrom
    ON P."from_address_id" = Afrom."id"
    JOIN "addresses" Ato
    ON P."to_address_id" = Ato."id"
WHERE Afrom."address" = '900 Somerville Avenue'
    AND "contents" like "%congratulatory%";
-- address is spelled incorrectly

-- Checking to see where the package went
SELECT "timestamp", "action", "address", "type"
FROM "scans" S
    JOIN "addresses" A
    ON S."address_id" = A."id"
WHERE "package_id" = (SELECT P."id"
                        FROM "packages" P
                            JOIN "addresses" A
                            ON P."from_address_id" = A."id"
                        WHERE A."address" = '900 Somerville Avenue'
                            AND "contents" like "%congratulatory%")
ORDER BY "timestamp";
-- package did indeed get delivered at mispelled/incorrect address



-- *** The Devious Delivery ***

-- Finding package "to-address"
SELECT P."id", Ato."address" as "to_address_name", "contents"
FROM "packages" P
    JOIN "addresses" Ato
    ON P."to_address_id" = Ato."id"
WHERE P."from_address_id" is Null;
-- found package with no from address and contents that seem to fit description

-- Checking to see where the package went
SELECT "timestamp", "action", "address", "type"
FROM "scans" S
    JOIN "addresses" A
    ON S."address_id" = A."id"
WHERE "package_id" = (SELECT P."id"
                        FROM "packages" P
                            JOIN "addresses" A
                            ON P."to_address_id" = A."id"
                        WHERE P."from_address_id" is Null);
-- it seems that it was dropped off at the Police Staton

-- *** The Forgotten Gift ***

-- Identifying package from description & address
SELECT P."id", Afrom."address" as "from_address_name", Ato."address" as "to_address_name", "contents"
FROM "packages" P
    JOIN "addresses" Afrom
    ON P."from_address_id" = Afrom."id"
    JOIN "addresses" Ato
    ON P."to_address_id" = Ato."id"
WHERE "from_address_name" = "109 Tileston Street"
    AND "to_address_name" = "728 Maple Place"
ORDER BY "timestamp";
-- package & contents found

-- Checking to see where the package went
SELECT "timestamp", "action", D."name" as "Driver", "address", "type"
FROM "scans" S
    JOIN "addresses" A
    ON S."address_id" = A."id"
    JOIN "drivers" D
    ON S."driver_id" = D."id"
WHERE "package_id" = (SELECT P."id"
                        FROM "packages" P
                            JOIN "addresses" Afrom
                            ON P."from_address_id" = Afrom."id"
                            JOIN "addresses" Ato
                            ON P."to_address_id" = Ato."id"
                        WHERE Afrom."address" = "109 Tileston Street"
                            AND Ato."address" = "728 Maple Place")
ORDER BY "timestamp";
-- it seems the package was dropped off at a warehouse and picked back up
