CREATE TABLE accommodations(id SERIAL PRIMARY KEY, owner_id INT REFERENCES users(id), name VARCHAR(60), description VARCHAR(120), price_per_night NUMERIC(5,2));