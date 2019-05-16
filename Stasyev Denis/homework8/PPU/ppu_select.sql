USE technotrack_formula_1;

-- PPU – Percentage of Paying Users – доля платящей аудитории относительно DAU

WITH RECURSIVE cte AS (
    SELECT MIN(CAST(created_at AS DATE)) AS dt FROM payments_in
        UNION ALL
    SELECT dt + INTERVAL 1 DAY
    FROM cte
    WHERE dt + INTERVAL 1 DAY <= (SELECT MAX(CAST(created_at AS DATE)) FROM payments_in)
),
pu_per_day AS (
    SELECT CAST(p.created_at AS DATE) AS dt,
        COUNT(DISTINCT p.client_id) as users_paying
    FROM payments_in AS p
    INNER JOIN sessions AS s
    ON s.client_id = p.client_id
	WHERE s.started_at <= p.created_at AND p.created_at <= s.ended_at
    GROUP BY dt
),
dau_per_day AS (
	WITH RECURSIVE cte AS
	(
		SELECT MIN(CAST(started_at AS DATE)) AS dt FROM sessions
			UNION ALL
		SELECT dt + INTERVAL 1 DAY
		FROM cte
		WHERE dt + INTERVAL 1 DAY <= (SELECT MAX(CAST(ended_at AS DATE)) FROM sessions)
	)
	SELECT cte.dt AS dt, COUNT(DISTINCT sessions.client_id) AS users_all
	FROM sessions RIGHT JOIN cte
	ON CAST(sessions.started_at AS DATE) <= cte.dt AND cte.dt <= CAST(sessions.ended_at AS DATE)
	GROUP BY cte.dt
	ORDER BY cte.dt
)
SELECT cte.dt AS `Date`, 
    COALESCE(COALESCE(pu.users_paying, 0) / COALESCE(dau.users_all, 1), 0) AS `PPU – Percentage of Paying Users`
FROM cte
LEFT JOIN pu_per_day AS pu ON cte.dt = pu.dt
LEFT JOIN dau_per_day AS dau ON cte.dt = dau.dt;

