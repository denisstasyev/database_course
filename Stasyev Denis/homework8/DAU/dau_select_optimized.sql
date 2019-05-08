USE technotrack_formula_1;

SELECT CAST(created_at AS DATE) AS dt, COUNT(DISTINCT payments_in.client_id)
FROM payments_in
GROUP BY dt;
