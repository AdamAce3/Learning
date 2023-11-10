CREATE TABLE IF NOT EXISTS "passengers" (
    "id",
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "check-ins" (
    "id",
    "passenger_id",
    "datetime" NUMERIC DEFAULT CURRENT_TIMESTAMP,
    "flight_id",
    PRIMARY KEY ("id"),
    FOREIGN KEY ("passenger_id") REFERENCES "passengers",
    FOREIGN KEY ("flight_id") REFERENCES "flights"
);

CREATE TABLE IF NOT EXISTS "airlines" (
    "id",
    "name" TEXT NOT NULL UNIQUE,
    "concourse" TEXT CHECK("concourse" in ("A","B","C","D","E","F","T")),
    PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "flights" (
    "id",
    "flight_number" INTEGER NOT NULL,
    "airline_id",
    "origin" TEXT NOT NULL CHECK(length("origin") = 3),
    "destination" TEXT NOT NULL CHECK(length("destination") = 3),
    "departure" NUMERIC NOT NULL,
    "arrival" NUMERIC NOT NULL,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("airline_id") REFERENCES "airlines"
);