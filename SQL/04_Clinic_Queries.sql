-- PlatinumRx Assignment - Clinic Management System
-- Replace the year value '2021' or month '2021-10' as needed.

-- Q1: Revenue from each sales channel in a given year
SELECT
    sales_channel,
    SUM(amount)            AS total_revenue,
    COUNT(oid)             AS total_transactions
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel
ORDER BY total_revenue DESC;


-- Q2: Top 10 most valuable customers for a given year
SELECT
    cs.uid,
    c.name,
    c.mobile,
    SUM(cs.amount)         AS total_spend
FROM clinic_sales cs
JOIN customer c ON cs.uid = c.uid
WHERE YEAR(cs.datetime) = 2021
GROUP BY cs.uid, c.name, c.mobile
ORDER BY total_spend DESC
LIMIT 10;


-- Q3: Month-wise revenue, expense, profit, and status for a given year
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(datetime, '%Y-%m') AS month,
        SUM(amount)                    AS total_revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = 2021
    GROUP BY month
),
monthly_expenses AS (
    SELECT
        DATE_FORMAT(datetime, '%Y-%m') AS month,
        SUM(amount)                    AS total_expenses
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY month
)
SELECT
    r.month,
    COALESCE(r.total_revenue,  0)                              AS revenue,
    COALESCE(e.total_expenses, 0)                              AS expenses,
    COALESCE(r.total_revenue, 0) - COALESCE(e.total_expenses, 0) AS profit,
    CASE
        WHEN COALESCE(r.total_revenue, 0) > COALESCE(e.total_expenses, 0)
        THEN 'Profitable'
        ELSE 'Not-Profitable'
    END                                                        AS status
FROM monthly_revenue r
LEFT JOIN monthly_expenses e ON r.month = e.month
ORDER BY r.month;


-- Q4: For each city, find the most profitable clinic for a given month
WITH clinic_profit AS (
    SELECT
        cl.cid,
        cl.clinic_name,
        cl.city,
        DATE_FORMAT(cs.datetime, '%Y-%m')       AS month,
        SUM(cs.amount)                          AS revenue
    FROM clinic_sales cs
    JOIN clinics cl ON cs.cid = cl.cid
    WHERE DATE_FORMAT(cs.datetime, '%Y-%m') = '2021-10'   
    GROUP BY cl.cid, cl.clinic_name, cl.city, month
),
clinic_expense AS (
    SELECT
        cid,
        DATE_FORMAT(datetime, '%Y-%m')          AS month,
        SUM(amount)                             AS expenses
    FROM expenses
    WHERE DATE_FORMAT(datetime, '%Y-%m') = '2021-10'
    GROUP BY cid, month
),
clinic_net AS (
    SELECT
        cp.city,
        cp.cid,
        cp.clinic_name,
        cp.month,
        cp.revenue - COALESCE(ce.expenses, 0)  AS profit
    FROM clinic_profit cp
    LEFT JOIN clinic_expense ce ON cp.cid = ce.cid AND cp.month = ce.month
),
ranked AS (
    SELECT *,
        RANK() OVER (PARTITION BY city ORDER BY profit DESC) AS rnk
    FROM clinic_net
)
SELECT city, cid, clinic_name, month, profit
FROM ranked
WHERE rnk = 1
ORDER BY city;


-- Q5: For each state, find the second least profitable clinic for a given month
WITH clinic_profit AS (
    SELECT
        cl.cid,
        cl.clinic_name,
        cl.state,
        DATE_FORMAT(cs.datetime, '%Y-%m')       AS month,
        SUM(cs.amount)                          AS revenue
    FROM clinic_sales cs
    JOIN clinics cl ON cs.cid = cl.cid
    WHERE DATE_FORMAT(cs.datetime, '%Y-%m') = '2021-10'
    GROUP BY cl.cid, cl.clinic_name, cl.state, month
),
clinic_expense AS (
    SELECT
        cid,
        DATE_FORMAT(datetime, '%Y-%m')          AS month,
        SUM(amount)                             AS expenses
    FROM expenses
    WHERE DATE_FORMAT(datetime, '%Y-%m') = '2021-10'
    GROUP BY cid, month
),
clinic_net AS (
    SELECT
        cp.state,
        cp.cid,
        cp.clinic_name,
        cp.month,
        cp.revenue - COALESCE(ce.expenses, 0)  AS profit
    FROM clinic_profit cp
    LEFT JOIN clinic_expense ce ON cp.cid = ce.cid AND cp.month = ce.month
),
ranked AS (
    SELECT *,
        DENSE_RANK() OVER (PARTITION BY state ORDER BY profit ASC) AS rnk
    FROM clinic_net
)
SELECT state, cid, clinic_name, month, profit
FROM ranked
WHERE rnk = 2
ORDER BY state;
