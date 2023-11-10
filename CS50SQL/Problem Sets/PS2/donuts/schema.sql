CREATE TABLE IF NOT EXISTS "ingredients" (
    "id",
    "name" TEXT UNIQUE NOT NULL,
    "unit" TEXT UNIQUE NOT NULL,
    "price_per_unit" NUMERIC(20, 3),
    PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "donuts" (
    "id",
    "name" TEXT UNIQUE NOT NULL,
    "gluten_free" TEXT CHECK("gluten_free" in ("yes", "no")),
    "price_per_donut" NUMERIC(20, 3),
    PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "donuts_ingredients" (
    "donut_id",
    "ingredient_id",
    PRIMARY KEY ("donut_id", "ingredient_id"),
    FOREIGN KEY ("donut_id") REFERENCES "donuts",
    FOREIGN KEY ("ingredient_id") REFERENCES "ingredients"
);

CREATE TABLE IF NOT EXISTS "orders" (
    "id",
    "customer_id",
    PRIMARY KEY ("id"),
    FOREIGN KEY ("customer_id") REFERENCES "customers"
);

CREATE TABLE IF NOT EXISTS "orders_donuts" (
    "order_id",
    "donut_id",
    PRIMARY KEY ("order_id", "donut_id"),
    FOREIGN KEY ("order_id") REFERENCES "orders",
    FOREIGN KEY ("donut_id") REFERENCES "donuts"
);

CREATE TABLE IF NOT EXISTS "customers" (
    "id",
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "customers_orders" (
    "customer_id",
    "order_id",
    PRIMARY KEY ("customer_id", "order_id"),
    FOREIGN KEY ("customer_id") REFERENCES "customers",
    FOREIGN KEY ("order_id") REFERENCES "orders"
);