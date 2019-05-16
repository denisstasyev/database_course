USE technotrack_formula_1;

-- DAU - Daily Active Users

WITH RECURSIVE cte AS
(
    SELECT MIN(CAST(started_at AS DATE)) AS dt FROM sessions
        UNION ALL
	SELECT dt + INTERVAL 1 DAY
	FROM cte
    WHERE dt + INTERVAL 1 DAY <= (SELECT MAX(CAST(ended_at AS DATE)) FROM sessions)
)
SELECT cte.dt AS `Date`, COUNT(DISTINCT sessions.client_id) AS `DAU`
FROM sessions RIGHT JOIN cte
ON CAST(sessions.started_at AS DATE) <= cte.dt AND cte.dt <= CAST(sessions.ended_at AS DATE)
GROUP BY cte.dt
ORDER BY cte.dt;
