-- Travel Booking Cancellation & Customer Experience Analysis
-- SQL Analysis
-- Dataset: Travel & Tourism
-- Records: 1,000
--
-- Business Objective:
-- Investigate booking behaviour, cancellation patterns,
-- booking value and customer experience to identify
-- potential business insights and recommendations.


-- ==========================================
-- 1. DATA EXPLORATION
-- ==========================================

-- 1.1 Check total number of bookings

SELECT COUNT(*) AS total_bookings
FROM travel_bookings;


-- 1.2 Check for duplicate Booking IDs

SELECT
    "Booking_ID",
    COUNT(*) AS booking_count
FROM travel_bookings
GROUP BY "Booking_ID"
HAVING COUNT(*) > 1;


-- 1.3 Calculate overall cancellation rate

SELECT
    COUNT(*) AS total_bookings,
    SUM(
        CASE
            WHEN "Cancellation_Status" = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_bookings,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN "Cancellation_Status" = 'Cancelled' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        1
    ) AS cancellation_rate
FROM travel_bookings;


-- 1.4 Analyse cancellation reasons

SELECT
    "Cancellation_Reason",
    COUNT(*) AS cancelled_bookings
FROM travel_bookings
WHERE "Cancellation_Status" = 'Cancelled'
GROUP BY "Cancellation_Reason"
ORDER BY cancelled_bookings DESC;


-- 1.5 Analyse cancellation rate by transportation type

SELECT
    "Transportation_Type",
    COUNT(*) AS total_bookings,
    SUM(
        CASE
            WHEN "Cancellation_Status" = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_bookings,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN "Cancellation_Status" = 'Cancelled' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        1
    ) AS cancellation_rate
FROM travel_bookings
GROUP BY "Transportation_Type"
ORDER BY cancellation_rate DESC;


-- 1.6 Analyse cancellation rate by destination

-- Only destinations with at least 20 bookings are included
-- to avoid drawing conclusions from very small samples.

SELECT
    "Destination_City",
    COUNT(*) AS total_bookings,
    SUM(
        CASE
            WHEN "Cancellation_Status" = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_bookings,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN "Cancellation_Status" = 'Cancelled' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        1
    ) AS cancellation_rate
FROM travel_bookings
GROUP BY "Destination_City"
HAVING COUNT(*) >= 20
ORDER BY cancellation_rate DESC;


-- 1.7 Analyse cancellation rate by booking lead time
-- Booking lead time is calculated as the number of days
-- between the booking date and travel date.

WITH booking_data AS (
    SELECT
        "Booking_ID",
        "Booking_Date"::date AS booking_date,
        "Travel_Date"::date AS travel_date,
        "Cancellation_Status"
    FROM travel_bookings
),

lead_time_data AS (
    SELECT
        CASE
            WHEN (travel_date - booking_date) <= 30 THEN '0-30 days'
            WHEN (travel_date - booking_date) <= 60 THEN '31-60 days'
            WHEN (travel_date - booking_date) <= 90 THEN '61-90 days'
            ELSE '90+ days'
        END AS booking_lead_time,
        "Cancellation_Status"
    FROM booking_data
)

SELECT
    booking_lead_time,
    COUNT(*) AS total_bookings,
    SUM(
        CASE
            WHEN "Cancellation_Status" = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_bookings,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN "Cancellation_Status" = 'Cancelled' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        1
    ) AS cancellation_rate
FROM lead_time_data
GROUP BY booking_lead_time
ORDER BY
    CASE booking_lead_time
        WHEN '0-30 days' THEN 1
        WHEN '31-60 days' THEN 2
        WHEN '61-90 days' THEN 3
        WHEN '90+ days' THEN 4
    END;


-- 1.8 Analyse cancellation rate by trip value
-- Groups bookings by total trip cost to assess cancellation behaviour
-- and the trip value associated with cancelled bookings.

WITH booking_value AS (
    SELECT
        "Booking_ID",
        "Total_Trip_Cost",
        "Cancellation_Status"
    FROM travel_bookings
),

value_groups AS (
    SELECT
        CASE
            WHEN "Total_Trip_Cost" < 100000 THEN 'Under 100k'
            WHEN "Total_Trip_Cost" < 250000 THEN '100k-249k'
            WHEN "Total_Trip_Cost" < 500000 THEN '250k-499k'
            ELSE '500k+'
        END AS trip_value_band,
        "Total_Trip_Cost",
        "Cancellation_Status"
    FROM booking_value
)

SELECT
    trip_value_band,
    COUNT(*) AS total_bookings,
    SUM(
        CASE
            WHEN "Cancellation_Status" = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_bookings,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN "Cancellation_Status" = 'Cancelled' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        1
    ) AS cancellation_rate,
    SUM(
        CASE
            WHEN "Cancellation_Status" = 'Cancelled'
            THEN "Total_Trip_Cost"
            ELSE 0
        END
    ) AS cancelled_trip_value

FROM value_groups

GROUP BY trip_value_band

ORDER BY
    CASE trip_value_band
        WHEN 'Under 100k' THEN 1
        WHEN '100k-249k' THEN 2
        WHEN '250k-499k' THEN 3
        WHEN '500k+' THEN 4
    END;


-- 1.9 Customer rating distribution
-- Groups customer ratings into broader bands
-- to identify overall satisfaction patterns.

SELECT
    CASE
        WHEN "Customer_Rating" < 2 THEN 'Below 2'
        WHEN "Customer_Rating" < 3 THEN '2.0-2.9'
        WHEN "Customer_Rating" < 4 THEN '3.0-3.9'
        ELSE '4.0-5.0'
    END AS rating_band,

    COUNT(*) AS booking_count,

    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        1
    ) AS percentage_of_rated_bookings

FROM travel_bookings

WHERE "Cancellation_Status" = 'Not Cancelled'
  AND "Customer_Rating" > 0

GROUP BY
    CASE
        WHEN "Customer_Rating" < 2 THEN 'Below 2'
        WHEN "Customer_Rating" < 3 THEN '2.0-2.9'
        WHEN "Customer_Rating" < 4 THEN '3.0-3.9'
        ELSE '4.0-5.0'
    END

ORDER BY MIN("Customer_Rating");


-- 2.0 Analyse cancellation rate by trip value
-- Groups bookings by total trip cost to assess cancellation behaviour
-- and the trip value associated with cancelled bookings.

WITH booking_value AS (
    SELECT
        "Booking_ID",
        "Total_Trip_Cost",
        "Cancellation_Status"
    FROM travel_bookings
),

value_groups AS (
    SELECT
        CASE
            WHEN "Total_Trip_Cost" < 100000 THEN 'Under 100k'
            WHEN "Total_Trip_Cost" < 250000 THEN '100k-249k'
            WHEN "Total_Trip_Cost" < 500000 THEN '250k-499k'
            ELSE '500k+'
        END AS trip_value_band,
        "Total_Trip_Cost",
        "Cancellation_Status"
    FROM booking_value
)

SELECT
    trip_value_band,
    COUNT(*) AS total_bookings,

    SUM(
        CASE
            WHEN "Cancellation_Status" = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_bookings,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN "Cancellation_Status" = 'Cancelled' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        1
    ) AS cancellation_rate,

    SUM(
        CASE
            WHEN "Cancellation_Status" = 'Cancelled'
            THEN "Total_Trip_Cost"
            ELSE 0
        END
    ) AS cancelled_trip_value

FROM value_groups

GROUP BY trip_value_band

ORDER BY
    CASE trip_value_band
        WHEN 'Under 100k' THEN 1
        WHEN '100k-249k' THEN 2
        WHEN '250k-499k' THEN 3
        WHEN '500k+' THEN 4
    END;


-- 2.1 Analyse cancellation rate by discount amount
-- Groups bookings by discount amount to assess cancellation behaviour.

SELECT
    CASE
        WHEN "Discount_Amount" = 0 THEN 'No discount'
        WHEN "Discount_Amount" < 10000 THEN 'Low discount'
        WHEN "Discount_Amount" < 25000 THEN 'Medium discount'
        ELSE 'High discount'
    END AS discount_band,

    COUNT(*) AS total_bookings,

    SUM(
        CASE
            WHEN "Cancellation_Status" = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_bookings,

    ROUND(
        (
            100.0 * SUM(
                CASE
                    WHEN "Cancellation_Status" = 'Cancelled' THEN 1
                    ELSE 0
                END
            ) / COUNT(*)
        )::numeric,
        1
    ) AS cancellation_rate

FROM travel_bookings

GROUP BY
    CASE
        WHEN "Discount_Amount" = 0 THEN 'No discount'
        WHEN "Discount_Amount" < 10000 THEN 'Low discount'
        WHEN "Discount_Amount" < 25000 THEN 'Medium discount'
        ELSE 'High discount'
    END

ORDER BY
    MIN("Discount_Amount");


