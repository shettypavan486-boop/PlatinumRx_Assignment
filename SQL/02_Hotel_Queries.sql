-- PlatinumRx Assignment - Hotel Management System

-- Q1: For every user, get user_id and last booked room_no
SELECT
    u.user_id,
    u.name,
    b.room_no AS last_booked_room
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE b.booking_date = (
    SELECT MAX(b2.booking_date)
    FROM bookings b2
    WHERE b2.user_id = u.user_id
)
ORDER BY u.user_id;


-- Q2: booking_id and total billing amount for bookings in November 2021
-- Total billing = SUM(item_quantity * item_rate)
SELECT
    bc.booking_id,
    SUM(bc.item_quantity * i.item_rate)  AS total_billing_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE DATE_FORMAT(bc.bill_date, '%Y-%m') = '2021-11'
GROUP BY bc.booking_id
ORDER BY total_billing_amount DESC;


-- Q3: bill_id and bill amount for bills in October 2021 with amount > 1000
SELECT
    bc.bill_id,
    SUM(bc.item_quantity * i.item_rate)  AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE DATE_FORMAT(bc.bill_date, '%Y-%m') = '2021-10'
GROUP BY bc.bill_id
HAVING bill_amount > 1000
ORDER BY bill_amount DESC;


-- Q4: Most ordered and least ordered item of each month in 2021
WITH monthly_item_qty AS (
    SELECT
        DATE_FORMAT(bc.bill_date, '%Y-%m') AS order_month,
        i.item_name,
        SUM(bc.item_quantity)              AS total_quantity
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY order_month, i.item_name
),
ranked AS (
    SELECT
        order_month,
        item_name,
        total_quantity,
        RANK() OVER (PARTITION BY order_month ORDER BY total_quantity DESC) AS rank_high,
        RANK() OVER (PARTITION BY order_month ORDER BY total_quantity ASC)  AS rank_low
    FROM monthly_item_qty
)
SELECT
    order_month,
    MAX(CASE WHEN rank_high = 1 THEN item_name END) AS most_ordered_item,
    MAX(CASE WHEN rank_low  = 1 THEN item_name END) AS least_ordered_item
FROM ranked
GROUP BY order_month
ORDER BY order_month;


-- Q5: Customers with the second highest bill value of each month in 2021
WITH bill_totals AS (
    SELECT
        DATE_FORMAT(bc.bill_date, '%Y-%m') AS bill_month,
        bc.bill_id,
        b.user_id,
        u.name,
        SUM(bc.item_quantity * i.item_rate) AS bill_amount
    FROM booking_commercials bc
    JOIN items    i ON bc.item_id    = i.item_id
    JOIN bookings b ON bc.booking_id = b.booking_id
    JOIN users    u ON b.user_id     = u.user_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY bill_month, bc.bill_id, b.user_id, u.name
),
ranked_bills AS (
    SELECT
        bill_month,
        bill_id,
        user_id,
        name,
        bill_amount,
        DENSE_RANK() OVER (PARTITION BY bill_month ORDER BY bill_amount DESC) AS bill_rank
    FROM bill_totals
)
SELECT
    bill_month,
    bill_id,
    user_id,
    name          AS customer_name,
    bill_amount
FROM ranked_bills
WHERE bill_rank = 2
ORDER BY bill_month;
