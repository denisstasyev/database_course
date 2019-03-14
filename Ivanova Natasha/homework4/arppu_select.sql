-- ARPPU — Average Revenue Per Paying User — средний доход с одного платящего пользователя


WITH RECURSIVE 
cte AS
(
   SELECT MIN(CAST(payment_dttm AS DATE)) AS dt FROM payments
        UNION ALL
   SELECT cte.dt + INTERVAL 1 DAY
        FROM cte
        WHERE cte.dt + INTERVAL 1 DAY <= (SELECT MAX(CAST(payment_dttm AS DATE)) AS dt FROM payments)
),
PUD AS
(
    SELECT CAST(payment_dttm AS DATE) AS dt, SUM(payment_sum) as sum
	    FROM payments
        GROUP BY dt
),
DAU AS
(
    SELECT CAST(payment_dttm AS DATE) AS dt, COUNT(DISTINCT  payments.user_id) as count
        FROM payments
        GROUP BY dt
)
SELECT cte.dt as day, COALESCE(pay.sum, 0) / COALESCE(PU.count, 1) as ARPPU
    FROM cte
    LEFT JOIN PUD AS pay ON cte.dt = pay.dt
    LEFT JOIN DAU AS PU ON cte.dt = PU.dt;



> результаты...

+------------+-------------+
| day        | ARPPU       |
+------------+-------------+
| 2018-08-07 |  902.000000 |
| 2018-08-08 |    0.000000 |
| 2018-08-09 |    0.000000 |
| 2018-08-10 |  317.000000 |
| 2018-08-11 |  135.000000 |
| 2018-08-12 |  330.000000 |
| 2018-08-13 |  615.000000 |
| 2018-08-14 |  510.000000 |
| 2018-08-15 |  372.000000 |
| 2018-08-16 |   28.000000 |
| 2018-08-17 |  731.500000 |
| 2018-08-18 |  839.000000 |
| 2018-08-19 |  381.500000 |
| 2018-08-20 |  508.000000 |
| 2018-08-21 |  277.000000 |
| 2018-08-22 |    0.000000 |
| 2018-08-23 |  443.500000 |
| 2018-08-24 |  556.250000 |
| 2018-08-25 |  528.500000 |
| 2018-08-26 |    0.000000 |
| 2018-08-27 |  818.500000 |
| 2018-08-28 |  633.750000 |
| 2018-08-29 |  537.000000 |
| 2018-08-30 |  476.750000 |
| 2018-08-31 |  348.666667 |
| 2018-09-01 |  466.000000 |
| 2018-09-02 |  154.500000 |
| 2018-09-03 |    0.000000 |
| 2018-09-04 |  549.000000 |
| 2018-09-05 |  800.000000 |
| 2018-09-06 |  665.750000 |
| 2018-09-07 |  584.000000 |
| 2018-09-08 |  448.500000 |
| 2018-09-09 |  510.666667 |
| 2018-09-10 |  629.750000 |
| 2018-09-11 |  615.200000 |
| 2018-09-12 |  731.333333 |
| 2018-09-13 |  532.000000 |
| 2018-09-14 |  479.333333 |
| 2018-09-15 |  586.500000 |
| 2018-09-16 |  641.444444 |
| 2018-09-17 |  418.250000 |
| 2018-09-18 |  350.000000 |
| 2018-09-19 |  475.375000 |
| 2018-09-20 |  633.333333 |
| 2018-09-21 |  553.750000 |
| 2018-09-22 |  263.000000 |
| 2018-09-23 |  733.400000 |
| 2018-09-24 |  776.600000 |
| 2018-09-25 |  614.222222 |
| 2018-09-26 | 1056.833333 |
| 2018-09-27 |  420.785714 |
| 2018-09-28 |  994.272727 |
| 2018-09-29 |  837.692308 |
| 2018-09-30 | 1100.750000 |
+------------+-------------+