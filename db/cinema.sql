DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS films;

CREATE TABLE customer (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  funds INT
);

CREATE TABLE films (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  price INT
);

CREATE TABLE tickets (
  id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customer(id),
  films_id INT REFERENCES films(id)
);