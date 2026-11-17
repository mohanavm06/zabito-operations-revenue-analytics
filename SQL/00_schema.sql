-- Core dimensions
CREATE TABLE dim_property (
  property_id      VARCHAR(50) PRIMARY KEY,
  property_name    VARCHAR(200),
  city             VARCHAR(100),
  micro_market     VARCHAR(100),
  property_type    VARCHAR(50)  -- hostel / co-living
);

CREATE TABLE dim_room (
  room_id          VARCHAR(50) PRIMARY KEY,
  property_id      VARCHAR(50),
  room_type        VARCHAR(50), -- single/double/dorm etc
  bed_count        INT,
  FOREIGN KEY (property_id) REFERENCES dim_property(property_id)
);

-- Bookings / stays
CREATE TABLE fact_booking (
  booking_id       VARCHAR(50) PRIMARY KEY,
  customer_id      VARCHAR(50),
  property_id      VARCHAR(50),
  room_id          VARCHAR(50),
  checkin_date     DATE,
  checkout_date    DATE,
  booked_on        DATE,
  channel          VARCHAR(50),
  base_price_day   DECIMAL(12,2),
  discount_amount  DECIMAL(12,2),
  discount_code    VARCHAR(50),
  status           VARCHAR(30)  -- active/completed/cancelled
);

-- Optional: churn events
CREATE TABLE fact_churn (
  customer_id      VARCHAR(50),
  property_id      VARCHAR(50),
  churn_date       DATE,
  churn_reason     VARCHAR(100),
  service_ticket_ct INT,
  PRIMARY KEY (customer_id, property_id, churn_date)
);

-- Calendar (for daily occupancy modeling)
CREATE TABLE dim_date (
  dt DATE PRIMARY KEY,
  year INT,
  month INT,
  month_start DATE,
  month_end DATE,
  weekday INT
);
