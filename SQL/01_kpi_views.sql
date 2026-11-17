-- Nights per booking
CREATE VIEW v_booking_nights AS
SELECT
  b.booking_id,
  b.customer_id,
  b.property_id,
  b.room_id,
  b.checkin_date,
  b.checkout_date,
  (b.checkout_date - b.checkin_date) AS nights,
  b.base_price_day,
  b.discount_amount,
  (b.base_price_day - COALESCE(b.discount_amount,0)) AS net_price_day
FROM fact_booking b
WHERE b.status IN ('active','completed');
