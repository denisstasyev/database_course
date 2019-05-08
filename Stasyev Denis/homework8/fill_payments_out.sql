USE technotrack_formula_1;

INSERT INTO payments_out (client_id, ticket_id, payment_out_size, created_at, reason) 
SELECT p_in.client_id,
       p_in.ticket_id,
       (p_in.payment_in_size - costs.price) AS `change`, 
       DATE(NOW()), 
       "change" 
FROM payments_in AS p_in
INNER JOIN
(SELECT p.ticket_id, c.ticket_price_coefficient * p.price AS price
FROM (SELECT t.ticket_id AS ticket_id, 
             tr.ticket_price AS price, 
             t.category_id AS category_id
	  FROM tickets AS t 
      INNER JOIN tribunes AS tr
      ON t.tribune_id = tr.tribune_id) AS p
INNER JOIN categories AS c
ON p.category_id = c.category_id) AS costs 
ON p_in.ticket_id = costs.ticket_id
WHERE costs.price < p_in.payment_in_size;

SELECT * FROM payments_out;
