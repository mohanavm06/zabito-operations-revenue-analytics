Occupancy % =
DIVIDE([Occupied Nights], [Available Nights])

Net Revenue Proxy =
SUMX(Bookings, Bookings[NetPriceDay] * Bookings[Nights])

Early Churn (<=30d) =
CALCULATE(DISTINCTCOUNT(Churn[CustomerId]), Churn[DaysFromStart] <= 30)
