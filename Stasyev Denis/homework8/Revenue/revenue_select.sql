USE technotrack_formula_1;

SELECT CAST(created_at AS DATE) AS dt, SUM(payments_in.payment_in_size)
FROM payments_in
GROUP BY dt;



