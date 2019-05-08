USE technotrack_formula_1;

WITH RECURSIVE cte AS
(
    SELECT MIN(CAST(created_at AS DATE)) AS dt FROM payments_in
        UNION ALL
	SELECT dt + INTERVAL 1 DAY
	FROM cte
	WHERE dt + INTERVAL 1 DAY <= (SELECT MAX(CAST(created_at AS DATE)) FROM payments_in)
)
SELECT cte.dt, COUNT(DISTINCT payments_in.client_id)
FROM payments_in RIGHT JOIN cte ON CAST(payments_in.created_at AS DATE) = cte.dt
GROUP BY cte.dt
ORDER BY cte.dt;
