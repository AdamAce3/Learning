.import --csv meteorites.csv meteorites_temp

-- Reprensenting empty values as NULL
UPDATE "meteorites_temp"
SET "mass" = NULL
WHERE "mass" = '';
UPDATE "meteorites_temp"
SET "year" = NULL
WHERE "year" = '';
UPDATE "meteorites_temp"
SET "lat" = NULL
WHERE "lat" = '';
UPDATE "meteorites_temp"
SET "long" = NULL
WHERE "long" = '';

-- Rounding decimal values to nearest hundredths place
UPDATE "meteorites_temp"
SET "mass" = round("mass",2), "lat" = round("lat",2), "long" = round("long",2);

-- Removing "Relict" nametype meteorites
DELETE FROM "meteorites_temp"
WHERE "nametype" = 'Relict';

CREATE TABLE "meteorites" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "class" TEXT NOT NULL,
    "mass" NUMERIC(20,2),
    "discovery" TEXT CHECK("discovery" in ('Fell','Found')),
    "year" INTEGER,
    "lat" NUMERIC(20,2),
    "long" NUMERIC(20,2),
    PRIMARY KEY("id")
);

-- Imported cleaned data into final table in desired order by year, name
INSERT INTO "meteorites" ("name","class","mass","discovery","year","lat","long")
SELECT "name","class","mass","discovery","year","lat","long"
FROM "meteorites_temp"
ORDER BY "year", "name";

-- Dropping temp table
DROP TABLE "meteorites_temp";
