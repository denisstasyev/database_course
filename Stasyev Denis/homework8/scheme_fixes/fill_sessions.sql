USE technotrack_formula_1;

INSERT INTO sessions (client_id, started_at, ended_at) 
SELECT client_id, created_at - INTERVAL FLOOR(RAND() * 5) DAY, created_at + INTERVAL FLOOR(RAND() * 2) DAY FROM payments_in;

INSERT INTO sessions (client_id, started_at, ended_at) 
SELECT client_id, created_at - INTERVAL FLOOR(RAND() * 20 + 15) DAY , created_at - INTERVAL FLOOR(RAND() * 5 + 3) DAY FROM payments_in;

