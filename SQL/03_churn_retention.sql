-- Define "cohort month" as check-in month of first stay
WITH first_stay AS (
  SELECT customer_id, MIN(checkin_date) AS first_checkin
  FROM fact_booking
  WHERE status IN ('active','completed')
  GROUP BY customer_id
),
cohorts AS (
  SELECT
    f.customer_id,
    DATE_TRUNC('month', f.first_checkin) AS cohort_month
  FROM first_stay f
),
activity AS (
  SELECT
    b.customer_id,
    DATE_TRUNC('month', b.checkin_date) AS active_month
  FROM fact_booking b
  WHERE b.status IN ('active','completed')
  GROUP BY b.customer_id, DATE_TRUNC('month', b.checkin_date)
)
SELECT
  c.cohort_month,
  a.active_month,
  COUNT(DISTINCT a.customer_id) AS active_customers
FROM cohorts c
JOIN activity a ON a.customer_id = c.customer_id
GROUP BY c.cohort_month, a.active_month
ORDER BY c.cohort_month, a.active_month;
