-- Monthly stay-length by city/property/room_type
SELECT
  p.city,
  p.property_name,
  r.room_type,
  d.year,
  d.month,
  AVG(v.nights) AS avg_length_of_stay,
  COUNT(*) AS bookings
FROM v_booking_nights v
JOIN dim_property p ON p.property_id = v.property_id
JOIN dim_room r ON r.room_id = v.room_id
JOIN dim_date d ON d.dt = v.checkin_date
GROUP BY p.city, p.property_name, r.room_type, d.year, d.month
ORDER BY d.year, d.month, p.city, p.property_name;
