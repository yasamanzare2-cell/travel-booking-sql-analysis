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
