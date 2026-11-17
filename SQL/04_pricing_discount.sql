-- Discount utilization + net revenue proxy by micro-market
SELECT
  p.city,
  p.micro_market,
  DATE_TRUNC('month', b.checkin_date) AS month,
  COUNT(*) AS bookings,
  AVG(b.base_price_day) AS avg_base_price_day,
  AVG(COALESCE(b.discount_amount,0)) AS avg_discount_day,
  AVG(b.base_price_day - COALESCE(b.discount_amount,0)) AS avg_net_price_day,
  SUM((b.base_price_day - COALESCE(b.discount_amount,0)) * (b.checkout_date - b.checkin_date)) AS net_revenue_proxy
FROM fact_booking b
JOIN dim_property p ON p.property_id = b.property_id
WHERE b.status IN ('active','completed')
GROUP BY p.city, p.micro_market, DATE_TRUNC('month', b.checkin_date)
ORDER BY month, p.city, p.micro_market;
