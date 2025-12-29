import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import random

np.random.seed(42)

# ----------------------------
# Parameters
# ----------------------------
cities = ["Bangalore", "Hyderabad", "Chennai", "Pune", "Mumbai"]
room_types = ["Single", "Double", "Dorm"]
property_count = 12
customers = 1200
start_date = datetime(2024, 1, 1)
end_date = datetime(2025, 6, 30)

# ----------------------------
# Properties
# ----------------------------
properties = []
for i in range(property_count):
    properties.append({
        "property_id": f"P{i+1:03}",
        "property_name": f"Zabito_Property_{i+1}",
        "city": random.choice(cities),
        "micro_market": f"MM_{random.randint(1,4)}",
        "property_type": random.choice(["Hostel", "Co-living"])
    })

dim_property = pd.DataFrame(properties)

# ----------------------------
# Rooms
# ----------------------------
rooms = []
room_id = 1
for _, p in dim_property.iterrows():
    for rt in room_types:
        rooms.append({
            "room_id": f"R{room_id:04}",
            "property_id": p.property_id,
            "room_type": rt,
            "bed_count": 1 if rt == "Single" else 2 if rt == "Double" else 4
        })
        room_id += 1

dim_room = pd.DataFrame(rooms)

# ----------------------------
# Bookings
# ----------------------------
bookings = []
for i in range(customers):
    checkin = start_date + timedelta(days=random.randint(0, 500))
    nights = np.random.choice([7, 14, 30, 60, 90], p=[0.2, 0.25, 0.35, 0.15, 0.05])
    checkout = checkin + timedelta(days=int(nights))
    room = dim_room.sample(1).iloc[0]

    base_price = np.random.randint(600, 1500)
    discount = base_price * np.random.choice([0, 0.05, 0.1, 0.15], p=[0.6, 0.2, 0.15, 0.05])

    bookings.append({
        "booking_id": f"B{i+1:05}",
        "customer_id": f"C{i+1:05}",
        "property_id": room.property_id,
        "room_id": room.room_id,
        "checkin_date": checkin.date(),
        "checkout_date": checkout.date(),
        "booked_on": checkin.date() - timedelta(days=random.randint(1,15)),
        "channel": random.choice(["Direct", "OTA", "Corporate"]),
        "base_price_day": round(base_price, 2),
        "discount_amount": round(discount, 2),
        "discount_code": "DISC10" if discount > 0 else None,
        "status": "completed"
    })

fact_booking = pd.DataFrame(bookings)

# ----------------------------
# Churn (early-stage bias)
# ----------------------------
churn = []
for _, b in fact_booking.sample(frac=0.25).iterrows():
    churn.append({
        "customer_id": b.customer_id,
        "property_id": b.property_id,
        "churn_date": b.checkout_date,
        "churn_reason": random.choice(["Service", "Pricing", "Relocation"]),
        "service_ticket_ct": random.randint(0, 5)
    })

fact_churn = pd.DataFrame(churn)

# ----------------------------
# Export
# ----------------------------
dim_property.to_csv("data/raw/dim_property.csv", index=False)
dim_room.to_csv("data/raw/dim_room.csv", index=False)
fact_booking.to_csv("data/raw/fact_booking.csv", index=False)
fact_churn.to_csv("data/raw/fact_churn.csv", index=False)

print("Synthetic Zabito data generated successfully.")
