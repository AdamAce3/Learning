CREATE TABLE IF NOT EXISTS "users" (
    "id",
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "schools_universities" (
    "id",
    "name" TEXT NOT NULL UNIQUE,
    "type" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    "year_founded" TEXT NOT NULL,
    PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "companies" (
    "id",
    "name" TEXT NOT NULL UNIQUE,
    "industry" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "connections_people" (
    "user_id1",
    "user_id2",
    PRIMARY KEY ("user_id1", "user_id2"),
    FOREIGN KEY ("user_id1") REFERENCES "users",
    FOREIGN KEY ("user_id2") REFERENCES "users"
);

CREATE TABLE IF NOT EXISTS "connections_schools" (
    "user_id",
    "school_id",
    "start_date" NUMERIC NOT NULL DEFAULT CURRENT_DATE,
    "end_date" NUMERIC CHECK ("end_date" > "start_date"),
    "degree" TEXT NOT NULL,
    PRIMARY KEY ("user_id", "school_id"),
    FOREIGN KEY ("user_id") REFERENCES "users",
    FOREIGN KEY ("school_id") REFERENCES "schools_universities"
);

CREATE TABLE IF NOT EXISTS "connections_companies" (
    "user_id",
    "company_id",
    "start_date" NUMERIC NOT NULL DEFAULT CURRENT_DATE,
    "end_date" NUMERIC CHECK ("end_date" > "start_date"),
    "title" TEXT NOT NULL,
    PRIMARY KEY ("user_id", "company_id"),
    FOREIGN KEY ("user_id") REFERENCES "users",
    FOREIGN KEY ("company_id") REFERENCES "companies"
);